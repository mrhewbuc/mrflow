/**
 * @description Test class for mf_FlowUtils_OpenAI_ToolObjRequest.
 * Tests the functionality of setting dynamic properties on OpenAI Tool objects
 * through the invocable method used in Salesforce Flows.
 * ---------------------------------
 * @author Arthur Nunes - Mr.Hewbuc
 * @created September 14, 2025
 * @modified September 14, 2025
 * ---------------------------------
 * @version 1.0
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
        mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput input = new mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput();
        input.toolObject = testTool;
        input.propertiesJson = '{"param1": {"type": "string"}, "param2": {"type": "integer"}}';
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_OpenAI_ToolObjRequest.RequestWrapper> results = 
            mf_FlowUtils_OpenAI_ToolObjRequest.setProperties(new List<mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput>{input});
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
        mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput input = new mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput();
        input.toolObject = testTool;
        input.propertiesJson = '{"key1": "value1"}';
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_OpenAI_ToolObjRequest.RequestWrapper> results = 
            mf_FlowUtils_OpenAI_ToolObjRequest.setProperties(new List<mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput>{input});
        Test.stopTest();
        
        // Verify that properties object was created
        System.assertNotEquals(null, results[0].toolObject.parameters.properties, 'Properties object should be created');
        System.assertNotEquals(null, results[0].toolObject.parameters.properties.properties, 'Properties map should be set');
    }
    
    /**
     * @description Test with empty/null properties JSON.
     * Verifies that the tool object is returned unchanged.
     */
    @isTest
    static void testSetProperties_EmptyJson() {
        // Create test tool
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools testTool = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools();
        testTool.name = 'testFunction';
        
        // Test with null JSON
        mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput input = new mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput();
        input.toolObject = testTool;
        input.propertiesJson = null;
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_OpenAI_ToolObjRequest.RequestWrapper> results = 
            mf_FlowUtils_OpenAI_ToolObjRequest.setProperties(new List<mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput>{input});
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
        mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput input = new mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput();
        input.toolObject = testTool;
        input.propertiesJson = 'invalid json {]';
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_OpenAI_ToolObjRequest.RequestWrapper> results = 
            mf_FlowUtils_OpenAI_ToolObjRequest.setProperties(new List<mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput>{input});
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
        List<mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput> inputs = new List<mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput>();
        
        // Create first input
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools tool1 = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools();
        tool1.parameters = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters();
        mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput input1 = new mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput();
        input1.toolObject = tool1;
        input1.propertiesJson = '{"prop1": "value1"}';
        inputs.add(input1);
        
        // Create second input
        ExternalService.mrhewbuc.OpenAIRs_VT_Tools tool2 = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools();
        tool2.parameters = new ExternalService.mrhewbuc.OpenAIRs_VT_Tools_parameters();
        mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput input2 = new mf_FlowUtils_OpenAI_ToolObjRequest.FlowInput();
        input2.toolObject = tool2;
        input2.propertiesJson = '{"prop2": "value2"}';
        inputs.add(input2);
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_OpenAI_ToolObjRequest.RequestWrapper> results = 
            mf_FlowUtils_OpenAI_ToolObjRequest.setProperties(inputs);
        Test.stopTest();
        
        // Verify results
        System.assertEquals(2, results.size(), 'Should return two results');
        System.assertNotEquals(null, results[0].toolObject.parameters.properties, 'First tool properties should be set');
        System.assertNotEquals(null, results[1].toolObject.parameters.properties, 'Second tool properties should be set');
    }
}