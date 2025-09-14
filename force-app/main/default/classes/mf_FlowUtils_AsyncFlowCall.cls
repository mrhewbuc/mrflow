/**
 * @description Utility class for calling Flows asynchronously from within other Flows.
 * Enables Flow-to-Flow communication using future methods to avoid governor limits.
 * 
 * @author Arthur Nunes - Mr.Hewbuc
 * @created September 14, 2025
 * @modified September 14, 2025
 * @version 1.0
 */
public class mf_FlowUtils_AsyncFlowCall {
    
    /**
     * @description Invocable method to trigger a Flow asynchronously from another Flow.
     * Always uses future method for asynchronous execution.
     * @param inputs List of FlowInput containing flow name, JSON data, signal flag, and options
     * @return List of FlowOutput with execution status
     */
    @InvocableMethod(label='Async Flow Call' description='Triggers another Flow asynchronously with JSON input and options')
    public static List<FlowOutput> callFlow(List<FlowInput> inputs) {
        List<FlowOutput> outputs = new List<FlowOutput>();
        
        for(FlowInput input : inputs) {
            FlowOutput output = new FlowOutput();
            
            try {
                // Validate flow name
                if(String.isBlank(input.flowName)) {
                    output.success = false;
                    output.message = 'Flow name is required';
                    outputs.add(output);
                    continue;
                }
                
                // Convert options list to delimited string for future method
                String optionsString = input.options != null ? String.join(input.options, '|||') : null;
                
                // Queue for async execution
                executeFlowAsync(input.flowName, input.jsonString, input.isSignal, optionsString);
                output.success = true;
                output.message = 'Flow queued for asynchronous execution';
                
            } catch(Exception e) {
                output.success = false;
                output.message = 'Error: ' + e.getMessage();
                System.debug('Error in callFlow: ' + e.getMessage());
            }
            
            outputs.add(output);
        }
        
        return outputs;
    }
    
    /**
     * @description Future method to execute Flow asynchronously.
     * @param flowName API name of the Flow to execute
     * @param jsonString JSON string containing input variables for the Flow
     * @param isSignal Boolean flag passed to the target Flow
     * @param optionsString Delimited string of options to be converted back to list
     */
    @future
    private static void executeFlowAsync(String flowName, String jsonString, Boolean isSignal, String optionsString) {
        try {
            System.debug('=== Async Flow Execution START ===');
            System.debug('Flow Name: ' + flowName);
            System.debug('JSON Input: ' + jsonString);
            System.debug('Is Signal: ' + isSignal);
            System.debug('Options String: ' + optionsString);
            
            // Parse JSON input
            Map<String, Object> inputVariables = new Map<String, Object>();
            
            // Always pass isSignal to the flow
            inputVariables.put('isSignal', isSignal);
            
            // Add JSON data if provided
            if(String.isNotBlank(jsonString)) {
                inputVariables.put('jsonString', jsonString);
            }
            
            // Convert options string back to list and add if provided
            if(String.isNotBlank(optionsString)) {
                List<String> optionsList = optionsString.split('\\|\\|\\|');
                inputVariables.put('options', optionsList);
            }
            
            // Create and execute Flow
            Flow.Interview flowInterview = Flow.Interview.createInterview(flowName, inputVariables);
            flowInterview.start();
            
            System.debug('=== Async Flow Execution COMPLETE ===');
            
        } catch(Exception e) {
            System.debug('Error in executeFlowAsync: ' + e.getMessage());
            System.debug('Stack trace: ' + e.getStackTraceString());
        }
    }
    
    /**
     * @description Inner class representing input parameters for the invocable method.
     */
    public class FlowInput {
        /**
         * @description Name of the Flow to execute (API name)
         */
        @InvocableVariable(label='Flow Name' description='API name of the Flow to execute' required=true)
        public String flowName;
        
        /**
         * @description JSON string containing data for the target Flow
         */
        @InvocableVariable(label='JSON String' description='JSON data for the Flow' required=false)
        public String jsonString;
        
        /**
         * @description Signal flag to indicate if this is a platform event signal
         */
        @InvocableVariable(label='Is Signal' description='True if this is a platform event signal' required=false)
        public Boolean isSignal;
        
        /**
         * @description Collection of string options/arguments for flexible parameter passing
         * The target Flow manages the interpretation of these options
         */
        @InvocableVariable(label='Options' description='Collection of string options for the target Flow' required=false)
        public List<String> options;
    }
    
    /**
     * @description Inner class representing output from the invocable method.
     */
    public class FlowOutput {
        /**
         * @description Indicates whether the async Flow call was successfully queued
         */
        @InvocableVariable(label='Success' description='True if Flow call was queued successfully')
        public Boolean success;
        
        /**
         * @description Status message
         */
        @InvocableVariable(label='Message' description='Execution status message')
        public String message;
    }
}