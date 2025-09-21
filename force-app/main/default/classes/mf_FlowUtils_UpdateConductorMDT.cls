/**
 * @description Utility class for updating Custom Metadata Type records from Flow.
 * Updates existing MFConductors metadata records with dynamic field values.
 * 
 * @author [Your Name]
 * @created September 21, 2025
 * @modified September 21, 2025
 * @version 1.0
 */
public class mf_FlowUtils_UpdateConductorMDT {
    
    /**
     * @description Invocable method to update Custom Metadata Type records from Flow.
     * @param inputs List of UpdateInput containing master labels and field updates
     * @return List of UpdateOutput with execution status
     */
    @InvocableMethod(label='Update Conductor Metadata' description='Updates MFConductors metadata records')
    public static List<UpdateOutput> updateMetadata(List<UpdateInput> inputs) {
        List<UpdateOutput> outputs = new List<UpdateOutput>();
        
        for(UpdateInput input : inputs) {
            UpdateOutput output = new UpdateOutput();
            
            try {
                // Validate inputs
                if(input.fieldUpdates == null || Math.mod(input.fieldUpdates.size(), 2) != 0) {
                    output.success = false;
                    output.message = 'Field updates must be provided in pairs (field name, value)';
                    outputs.add(output);
                    continue;
                }
                
                // Convert lists to delimited strings for future method
                String masterLabelsString = String.join(input.masterLabels, '|||');
                String fieldUpdatesString = String.join(input.fieldUpdates, '|||');
                
                // Call future method to handle metadata deployment
                deployMetadataAsync(masterLabelsString, fieldUpdatesString);
                
                output.success = true;
                output.message = 'Metadata update queued for asynchronous processing';
                output.deploymentId = null; // Can't get deployment ID from future method
                
            } catch(Exception e) {
                output.success = false;
                output.message = e.getMessage();
            }
            
            outputs.add(output);
        }
        
        return outputs;
    }
    
    /**
     * @description Future method to deploy metadata changes asynchronously
     * @param masterLabelsString Delimited string of master labels
     * @param fieldUpdatesString Delimited string of field updates
     */
    @future
    private static void deployMetadataAsync(String masterLabelsString, String fieldUpdatesString) {
        try {
            // Parse delimited strings back to lists
            List<String> masterLabels = masterLabelsString.split('\\|\\|\\|');
            List<String> fieldUpdates = fieldUpdatesString.split('\\|\\|\\|');
            
            // Create deployment container
            Metadata.DeployContainer container = new Metadata.DeployContainer();
            
            // Process each master label
            for(String masterLabel : masterLabels) {
                // Create metadata record for update
                Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
                customMetadata.fullName = 'mrhewbuc__MFConductors__mdt.' + masterLabel;
                customMetadata.label = masterLabel;
                
                // Process field updates in pairs
                for(Integer i = 0; i < fieldUpdates.size(); i += 2) {
                    String fieldName = fieldUpdates[i];
                    String fieldValue = fieldUpdates[i + 1];
                    
                    Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
                    customField.field = fieldName;
                    customField.value = parseValue(fieldValue);
                    customMetadata.values.add(customField);
                }
                
                container.addMetadata(customMetadata);
            }
            
            // Deploy updates
            Id deploymentId = Metadata.Operations.enqueueDeployment(container, null);
            System.debug('Metadata deployment queued with ID: ' + deploymentId);
            
        } catch(Exception e) {
            System.debug('Error in deployMetadataAsync: ' + e.getMessage());
            System.debug('Stack trace: ' + e.getStackTraceString());
        }
    }
    
    /**
     * @description Simple type conversion for metadata values
     * @param value String value to parse
     * @return Parsed value with appropriate type
     */
    private static Object parseValue(String value) {
        if(String.isBlank(value)) {
            return null;
        }
        
        // Boolean check
        if(value.equalsIgnoreCase('true') || value.equalsIgnoreCase('false')) {
            return Boolean.valueOf(value);
        }
        
        // Number check
        if(value.isNumeric()) {
            return Integer.valueOf(value);
        }
        
        // Default to string
        return value;
    }
    
    /**
     * @description Input class for Flow
     */
    public class UpdateInput {
        @InvocableVariable(label='Master Labels' required=true)
        public List<String> masterLabels;
        
        @InvocableVariable(label='Field Updates' description='Pairs of field name and value' required=true)
        public List<String> fieldUpdates;
    }
    
    /**
     * @description Output class for Flow
     */
    public class UpdateOutput {
        @InvocableVariable(label='Success')
        public Boolean success;
        
        @InvocableVariable(label='Message')
        public String message;
        
        @InvocableVariable(label='Deployment ID')
        public String deploymentId;
    }
}