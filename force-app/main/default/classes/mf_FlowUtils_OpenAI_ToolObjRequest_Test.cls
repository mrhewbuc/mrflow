/**
 * @description Test class for mf_FlowUtils_OpenAI_ToolObjRequest.
 * Tests the functionality of setting dynamic properties and required fields on OpenAI Tool objects
 * through the invocable method used in Salesforce Flows.
 * ---------------------------------
 * @author Arthur Nunes - Mr.Hewbuc
 * @created September 14, 2025
 * @modified September 21, 2025
 * ---------------------------------
 * @version 1.1
 */
@isTest
private class mf_FlowUtils_OpenAI_ToolObjRequest_Test {
    
    /**
     * @description Test setting properties on a tool with valid JSON input.
     * Verifies that properties are correctly assigned to the nested structure.
     */
    @isTest
    static void testSetProperties_ValidInput() {
        // Create test tool object
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools testTool = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools();
        testTool.name = 'testFunction';
        testTool.name_set = true;
        
        // Create parameters
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters params = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters();
        params.z0type = 'object';
        params.z0type_set = true;
        testTool.parameters = params;
        testTool.parameters_set = true;
        
        // Create test input
        mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput input = new mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput();
        input.toolObject = testTool;
        input.propertiesJson = '{"param1": {"type": "string"}, "param2": {"type": "integer"}}';
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_OpenAI_ToolObjRequest.RequestWrapper> results = 
            mf_FlowUtils_OpenAI_ToolObjRequest.setProperties(new List<mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput>{input});
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, results.size(), 'Should return one result');
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools resultTool = results[0].toolObject;
        System.assertNotEquals(null, resultTool, 'Result tool should not be null');
        System.assertNotEquals(null, resultTool.parameters.properties, 'Properties should be set');
        System.assertNotEquals(null, resultTool.parameters.properties.properties, 'Nested properties map should be set');
        System.assertEquals(true, resultTool.parameters.properties.properties_set, 'Properties_set flag should be true');
        
        // Verify map contents
        Map<String, Object> propertiesMap = resultTool.parameters.properties.properties;
        System.assert(propertiesMap.containsKey('param1'), 'Should contain param1');
        System.assert(propertiesMap.containsKey('param2'), 'Should contain param2');
    }
    
    /**
     * @description Test setting required fields with valid comma-delimited string.
     * Verifies that required fields are correctly parsed and assigned.
     */
    @isTest
    static void testSetRequired_ValidInput() {
        // Create test tool object
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools testTool = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools();
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters params = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters();
        testTool.parameters = params;
        testTool.parameters_set = true;
        
        // Create test input
        mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput input = new mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput();
        input.toolObject = testTool;
        input.requiredFieldsString = 'field1,field2,field3';
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_OpenAI_ToolObjRequest.RequestWrapper> results = 
            mf_FlowUtils_OpenAI_ToolObjRequest.setProperties(new List<mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput>{input});
        Test.stopTest();
        
        // Verify results
        System.assertNotEquals(null, results[0].toolObject.parameters.required, 'Required fields should be set');
        System.assertEquals(3, results[0].toolObject.parameters.required.size(), 'Should have 3 required fields');
        System.assertEquals('field1', results[0].toolObject.parameters.required[0], 'First field should be field1');
        System.assertEquals('field2', results[0].toolObject.parameters.required[1], 'Second field should be field2');
        System.assertEquals('field3', results[0].toolObject.parameters.required[2], 'Third field should be field3');
        System.assertEquals(true, results[0].toolObject.parameters.required_set, 'Required_set flag should be true');
    }
    
    /**
     * @description Test setting both properties and required fields in one call.
     * Verifies that both operations work together.
     */
    @isTest
    static void testSetBoth_PropertiesAndRequired() {
        // Create test tool
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools testTool = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools();
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters params = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters();
        testTool.parameters = params;
        
        // Create input with both properties and required fields
        mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput input = new mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput();
        input.toolObject = testTool;
        input.propertiesJson = '{"userId": {"type": "string"}, "message": {"type": "string"}}';
        input.requiredFieldsString = 'userId, message'; // Test with spaces
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_OpenAI_ToolObjRequest.RequestWrapper> results = 
            mf_FlowUtils_OpenAI_ToolObjRequest.setProperties(new List<mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput>{input});
        Test.stopTest();
        
        // Verify both properties and required are set
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools resultTool = results[0].toolObject;
        System.assertNotEquals(null, resultTool.parameters.properties, 'Properties should be set');
        System.assertNotEquals(null, resultTool.parameters.required, 'Required should be set');
        System.assertEquals(2, resultTool.parameters.required.size(), 'Should have 2 required fields');
        System.assertEquals('userId', resultTool.parameters.required[0], 'First required field should be userId (trimmed)');
        System.assertEquals('message', resultTool.parameters.required[1], 'Second required field should be message (trimmed)');
    }
    
    /**
     * @description Test setting properties when parameters.properties is initially null.
     * Verifies that the properties object is created before assignment.
     */
    @isTest
    static void testSetProperties_NullProperties() {
        // Create test tool with parameters but no properties
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools testTool = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools();
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters params = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters();
        testTool.parameters = params;
        testTool.parameters_set = true;
        
        // Create test input
        mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput input = new mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput();
        input.toolObject = testTool;
        input.propertiesJson = '{"key1": "value1"}';
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_OpenAI_ToolObjRequest.RequestWrapper> results = 
            mf_FlowUtils_OpenAI_ToolObjRequest.setProperties(new List<mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput>{input});
        Test.stopTest();
        
        // Verify that properties object was created
        System.assertNotEquals(null, results[0].toolObject.parameters.properties, 'Properties object should be created');
        System.assertNotEquals(null, results[0].toolObject.parameters.properties.properties, 'Properties map should be set');
    }
    
    /**
     * @description Test with empty/null properties JSON and required fields.
     * Verifies that the tool object is returned unchanged.
     */
    @isTest
    static void testSetProperties_EmptyInputs() {
        // Create test tool
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools testTool = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools();
        testTool.name = 'testFunction';
        
        // Test with null JSON and null required
        mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput input = new mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput();
        input.toolObject = testTool;
        input.propertiesJson = null;
        input.requiredFieldsString = null;
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_OpenAI_ToolObjRequest.RequestWrapper> results = 
            mf_FlowUtils_OpenAI_ToolObjRequest.setProperties(new List<mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput>{input});
        Test.stopTest();
        
        // Verify tool is returned unchanged
        System.assertEquals(testTool, results[0].toolObject, 'Tool should be returned unchanged');
    }
    
    /**
     * @description Test error handling with invalid JSON input.
     * Verifies that the original tool object is returned on error.
     */
    @isTest
    static void testSetProperties_InvalidJson() {
        // Create test tool
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools testTool = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools();
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters params = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters();
        testTool.parameters = params;
        
        // Create input with invalid JSON
        mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput input = new mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput();
        input.toolObject = testTool;
        input.propertiesJson = 'invalid json {]';
        input.requiredFieldsString = 'field1,field2'; // Valid required fields
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_OpenAI_ToolObjRequest.RequestWrapper> results = 
            mf_FlowUtils_OpenAI_ToolObjRequest.setProperties(new List<mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput>{input});
        Test.stopTest();
        
        // Verify original tool is returned on error
        System.assertEquals(1, results.size(), 'Should return one result');
        System.assertEquals(testTool, results[0].toolObject, 'Should return original tool on error');
    }
    
    /**
     * @description Test with multiple inputs in batch.
     * Verifies that the method correctly processes multiple tool objects.
     */
    @isTest
    static void testSetProperties_MultipleInputs() {
        List<mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput> inputs = new List<mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput>();
        
        // Create first input - properties only
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools tool1 = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools();
        tool1.parameters = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters();
        mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput input1 = new mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput();
        input1.toolObject = tool1;
        input1.propertiesJson = '{"prop1": "value1"}';
        inputs.add(input1);
        
        // Create second input - required fields only
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools tool2 = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools();
        tool2.parameters = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters();
        mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput input2 = new mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput();
        input2.toolObject = tool2;
        input2.requiredFieldsString = 'fieldA,fieldB';
        inputs.add(input2);
        
        // Create third input - both
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools tool3 = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools();
        tool3.parameters = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters();
        mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput input3 = new mf_FlowUtils_OpenAI_ToolObjRequest.PropertiesInput();
        input3.toolObject = tool3;
        input3.propertiesJson = '{"prop3": "value3"}';
        input3.requiredFieldsString = 'prop3';
        inputs.add(input3);
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_OpenAI_ToolObjRequest.RequestWrapper> results = 
            mf_FlowUtils_OpenAI_ToolObjRequest.setProperties(inputs);
        Test.stopTest();
        
        // Verify results
        System.assertEquals(3, results.size(), 'Should return three results');
        System.assertNotEquals(null, results[0].toolObject.parameters.properties, 'First tool properties should be set');
        System.assertNotEquals(null, results[1].toolObject.parameters.required, 'Second tool required should be set');
        System.assertNotEquals(null, results[2].toolObject.parameters.properties, 'Third tool properties should be set');
        System.assertNotEquals(null, results[2].toolObject.parameters.required, 'Third tool required should be set');
    }
}