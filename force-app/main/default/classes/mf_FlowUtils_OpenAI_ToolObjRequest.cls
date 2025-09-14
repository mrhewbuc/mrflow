/**
 * @description Helper class for setting dynamic properties on OpenAI Tool objects in Salesforce External Services.
 * Handles the transformation of JSON properties to match the Salesforce-generated class structure
 * where additionalProperties creates a nested properties.properties structure.
 * ---------------------------------
 * @author Arthur Nunes - Mr.Hewbuc
 * @created September 14, 2025
 * @modified September 14, 2025
 * ---------------------------------
 * @version 1.0
 */
public class mf_FlowUtils_OpenAI_ToolObjRequest {
    
    /**
     * @description Invocable method to set dynamic properties on OpenAI Tool parameters.
     * Takes a tool object and JSON properties, then assigns them to the parameters.properties field.
     * @param inputs List of FlowInput containing the tool object and properties JSON
     * @return List of RequestWrapper containing the modified tool object
     */
    @InvocableMethod(label='Set Tool Parameters Properties' description='Set the parameters.properties field for OpenAI Tool')
    public static List<RequestWrapper> setProperties(List<FlowInput> inputs) {
        List<RequestWrapper> results = new List<RequestWrapper>();
        
        for(FlowInput input : inputs) {
            try {
                ExternalService.mrhewbuc.OpenAIRs_VT_Tools tool = input.toolObject;
                
                if(String.isNotBlank(input.propertiesJson) && tool.parameters != null) {
                    // Create properties object if null
                    if (tool.parameters.properties == null) {
                        tool.parameters.properties = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters_properties();
                    }
                    
                    // Parse JSON and assign map directly to the nested properties field
                    // The structure is parameters.properties.properties due to Salesforce's handling of additionalProperties
                    Map<String, Object> propertiesMap = (Map<String, Object>) JSON.deserializeUntyped(input.propertiesJson);
                    tool.parameters.properties.properties = propertiesMap;
                    tool.parameters.properties.properties_set = true;
                }
                
                RequestWrapper wrapper = new RequestWrapper();
                wrapper.toolObject = tool;
                results.add(wrapper);
                
            } catch(Exception e) {
                System.debug('ERROR: ' + e.getMessage());
                
                // Return the original tool object on error
                RequestWrapper errorWrapper = new RequestWrapper();
                errorWrapper.toolObject = input.toolObject;
                results.add(errorWrapper);
            }
        }
        
        return results;
    }
    
    /**
     * @description Inner class representing the input parameters for the invocable method from Salesforce Flow.
     * Contains the tool object to modify and the JSON string with properties to set.
     */
    public class FlowInput {
        /**
         * @description The OpenAI Tool object from External Service to be modified
         */
        @InvocableVariable(required=true)
        public ExternalService.mrhewbuc.OpenAIRs_VT_Tools toolObject;
        
        /**
         * @description JSON string containing the dynamic properties to set on the tool's parameters
         * Example: {"param1": {"type": "string"}, "param2": {"type": "integer"}}
         */
        @InvocableVariable(required=false)
        public String propertiesJson;
    }
    
    /**
     * @description Inner class to wrap the External Service tool object for the invocable method's output.
     * Returns the modified tool object back to the Flow.
     */
    public class RequestWrapper {
        /**
         * @description The modified OpenAI Tool object with updated properties
         */
        @InvocableVariable
        public ExternalService.mrhewbuc.OpenAIRs_VT_Tools toolObject;
    }
}