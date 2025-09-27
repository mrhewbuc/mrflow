/**
 * @description Helper class for setting dynamic properties and required parameters on OpenAI Tool objects.
 * Handles both JSON properties transformation and required fields assignment for Salesforce External Services.
 * ---------------------------------
 * @author Arthur Nunes - Mr.Hewbuc
 * @created September 14, 2025
 * @modified September 21, 2025
 * ---------------------------------
 * @version 1.1
 */
public class mf_FlowUtils_OpenAI_ToolObjRequest {
    
    /**
     * @description Invocable method to set dynamic properties on OpenAI Tool parameters.
     * Takes a tool object and JSON properties, then assigns them to the parameters.properties field.
     * @param inputs List of PropertiesInput containing the tool object and properties JSON
     * @return List of RequestWrapper containing the modified tool object
     */
    @InvocableMethod(label='Set Tool Parameters Properties' description='Set the parameters fields for OpenAI Tool')
    public static List<RequestWrapper> setProperties(List<PropertiesInput> inputs) {
        List<RequestWrapper> results = new List<RequestWrapper>();
        
        for(PropertiesInput input : inputs) {
            try {
                ExternalService.mrhewbuc.OpenAIRs_VT_Tools tool = input.toolObject;
                
                // Set properties if provided
                if(String.isNotBlank(input.propertiesJson)) {
                    setToolProperties(tool, input.propertiesJson);
                }
                
                // Set required fields if provided
                if(String.isNotBlank(input.requiredFieldsString)) {
                    setToolRequired(tool, input.requiredFieldsString);
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
     * @description Helper method to set properties on the tool parameters
     * @param tool The OpenAI Tool object to modify
     * @param propertiesJson JSON string containing the properties
     */
    private static void setToolProperties(ExternalService.mrhewbuc.OpenAIRs_VT_Tools tool, String propertiesJson) {
        if(tool.parameters == null) {
            return;
        }
        
        if (tool.parameters.properties == null) {
            tool.parameters.properties = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters_properties();
        }
        
        // Deserialize and ensure proper Map structure
        Map<String, Object> propertiesMap = (Map<String, Object>) JSON.deserializeUntyped(propertiesJson);
        
        // Process each property to ensure correct structure
        Map<String, Object> processedMap = new Map<String, Object>();
        for(String key : propertiesMap.keySet()) {
            Object value = propertiesMap.get(key);
            // Ensure each property value is a proper Map
            if(value instanceof Map<String, Object>) {
                processedMap.put(key, value);
            }
        }
        
        tool.parameters.properties.properties = processedMap;
        tool.parameters.properties.properties_set = true;
    }
    
    /**
     * @description Helper method to set required fields on the tool parameters
     * @param tool The OpenAI Tool object to modify
     * @param requiredFieldsString Comma-delimited string of required field names
     */
    private static void setToolRequired(ExternalService.mrhewbuc.OpenAIRs_VT_Tools tool, String requiredFieldsString) {
        if(tool.parameters == null) {
            return;
        }
        
        // Split the comma-delimited string into a list
        List<String> requiredFields = requiredFieldsString.split(',');
        
        // Trim whitespace from each field name
        for(Integer i = 0; i < requiredFields.size(); i++) {
            requiredFields[i] = requiredFields[i].trim();
        }
        
        // Set the required fields list
        tool.parameters.required = requiredFields;
        tool.parameters.required_set = true;
    }
    
    /**
     * @description Inner class representing the input parameters for the invocable method from Salesforce Flow.
     * Contains the tool object to modify and both properties JSON and required fields string.
     */
    public class PropertiesInput {
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
        
        /**
         * @description Comma-delimited string of field names that are required for the tool
         * Example: "param1,param2,param3"
         */
        @InvocableVariable(required=false)
        public String requiredFieldsString;
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