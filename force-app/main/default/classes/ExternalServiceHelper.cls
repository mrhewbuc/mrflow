public class ExternalServiceHelper {
    
    @InvocableMethod(label='Test All Properties' description='Tests all 4 property variations with same JSON input')
    public static List<RequestWrapper> setProperties(List<FlowInput> inputs) {
        List<RequestWrapper> results = new List<RequestWrapper>();
        
        System.debug('=== ExternalServiceHelper.setProperties START ===');
        System.debug('Number of inputs: ' + inputs.size());
        
        for(FlowInput input : inputs) {
            System.debug('--- Processing input ---');
            System.debug('Input requestObject: ' + input.requestObject);
            System.debug('Input propertiesJson: ' + input.propertiesJson);
            
            try {
                // Get the External Service object directly from the wrapper
                ExternalService.mrhewbuc.es_CreateRequest request = input.requestObject;
                System.debug('Original request object: ' + JSON.serialize(request));
                
                if(String.isNotBlank(input.propertiesJson)) {
                    System.debug('Testing all 5 property variations with JSON: ' + input.propertiesJson);
                    
                    // Test properties1 (additionalProperties: type: string)
                    try {
                        System.debug('=== Testing properties1 ===');
                        ExternalService.mrhewbuc.es_CreateRequest_properties1 prop1 = 
                            (ExternalService.mrhewbuc.es_CreateRequest_properties1) JSON.deserialize(
                                input.propertiesJson, 
                                ExternalService.mrhewbuc.es_CreateRequest_properties1.class
                            );
                        request.properties1 = prop1;
                        request.properties1_set = true;
                        System.debug('properties1 SUCCESS: ' + JSON.serialize(prop1));
                    } catch(Exception e) {
                        System.debug('properties1 FAILED: ' + e.getMessage());
                    }
                    
                    // Test properties2 (additionalProperties: oneOf)
                    try {
                        System.debug('=== Testing properties2 ===');
                        ExternalService.mrhewbuc.es_CreateRequest_properties2 prop2 = 
                            (ExternalService.mrhewbuc.es_CreateRequest_properties2) JSON.deserialize(
                                input.propertiesJson, 
                                ExternalService.mrhewbuc.es_CreateRequest_properties2.class
                            );
                        request.properties2 = prop2;
                        request.properties2_set = true;
                        System.debug('properties2 SUCCESS: ' + JSON.serialize(prop2));
                    } catch(Exception e) {
                        System.debug('properties2 FAILED: ' + e.getMessage());
                    }
                    
                    // Test properties3 (additionalProperties: true)
                    try {
                        System.debug('=== Testing properties3 ===');
                        ExternalService.mrhewbuc.es_CreateRequest_properties3 prop3 = 
                            (ExternalService.mrhewbuc.es_CreateRequest_properties3) JSON.deserialize(
                                input.propertiesJson, 
                                ExternalService.mrhewbuc.es_CreateRequest_properties3.class
                            );
                        request.properties3 = prop3;
                        request.properties3_set = true;
                        System.debug('properties3 SUCCESS: ' + JSON.serialize(prop3));
                    } catch(Exception e) {
                        System.debug('properties3 FAILED: ' + e.getMessage());
                    }
                    
                    // Test properties4 (additionalProperties: type: object)
                    try {
                        System.debug('=== Testing properties4 ===');
                        ExternalService.mrhewbuc.es_CreateRequest_properties4 prop4 = 
                            (ExternalService.mrhewbuc.es_CreateRequest_properties4) JSON.deserialize(
                                input.propertiesJson, 
                                ExternalService.mrhewbuc.es_CreateRequest_properties4.class
                            );
                        request.properties4 = prop4;
                        request.properties4_set = true;
                        System.debug('properties4 SUCCESS: ' + JSON.serialize(prop4));
                    } catch(Exception e) {
                        System.debug('properties4 FAILED: ' + e.getMessage());
                    }
                    // Test properties5 (nested data with additionalProperties: type: string)
                    try {
                        System.debug('=== Testing properties5 ===');
                        
                        // First, wrap the JSON in a data object if it isn't already
                        String wrappedJson = input.propertiesJson;
                        Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(input.propertiesJson);
                        
                        // Check if 'data' key exists, if not, wrap it
                        if (!jsonMap.containsKey('data')) {
                            wrappedJson = '{"data":' + input.propertiesJson + '}';
                            System.debug('Wrapped JSON for properties5: ' + wrappedJson);
                        }
                        
                        ExternalService.mrhewbuc.es_CreateRequest_properties5 prop5 = 
                            (ExternalService.mrhewbuc.es_CreateRequest_properties5) JSON.deserialize(
                                wrappedJson, 
                                ExternalService.mrhewbuc.es_CreateRequest_properties5.class
                            );
                        request.properties5 = prop5;
                        request.properties5_set = true;
                        System.debug('properties5 SUCCESS: ' + JSON.serialize(prop5));
                        System.debug('properties5 data field: ' + JSON.serialize(prop5.data));
                    } catch(Exception e) {
                        System.debug('properties5 FAILED: ' + e.getMessage());
                        System.debug('properties5 Stack trace: ' + e.getStackTraceString());
                    }                    
                }
                
                System.debug('Final request object: ' + JSON.serialize(request));
                
                // Wrap the modified External Service object for return
                RequestWrapper wrapper = new RequestWrapper();
                wrapper.requestObject = request;
                results.add(wrapper);
                System.debug('Added wrapper to results');
                
            } catch(Exception e) {
                System.debug('OUTER EXCEPTION: ' + e.getMessage());
                System.debug('Exception type: ' + e.getTypeName());
                System.debug('Stack trace: ' + e.getStackTraceString());
                
                RequestWrapper errorWrapper = new RequestWrapper();
                errorWrapper.requestObject = input.requestObject;
                results.add(errorWrapper);
            }
        }
        
        System.debug('=== ExternalServiceHelper.setProperties END ===');
        return results;
    }
    
    /**
     * @description Inner class to represent the input for the invocable method from Salesforce Flow.
     */
    public class FlowInput {
        @InvocableVariable(required=true)
        public ExternalService.mrhewbuc.es_CreateRequest requestObject;
        
        @InvocableVariable(required=false)
        public String propertiesJson;
    }
    
    /**
     * @description Inner class to wrap the External Service request object for the invocable method's output.
     */
    public class RequestWrapper {
        @InvocableVariable
        public ExternalService.mrhewbuc.es_CreateRequest requestObject;
    }
}