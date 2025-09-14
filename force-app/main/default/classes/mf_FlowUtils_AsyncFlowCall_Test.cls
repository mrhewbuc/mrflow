/**
 * @description Test class for mf_FlowUtils_AsyncFlowCall.
 * Provides code coverage for the async Flow execution utility.
 * 
 * @author Arthur Nunes - Mr.Hewbuc
 * @created September 14, 2025
 * @modified September 14, 2025
 * @version 1.0
 */
@isTest
private class mf_FlowUtils_AsyncFlowCall_Test {
    
    /**
     * @description Test successful async Flow call with all parameters
     */
    @isTest
    static void testCallFlow_Success() {
        // Create test input
        mf_FlowUtils_AsyncFlowCall.FlowInput input = new mf_FlowUtils_AsyncFlowCall.FlowInput();
        input.flowName = 'Test_Flow_Name';
        input.jsonString = '{"key1": "value1", "key2": "value2"}';
        input.isSignal = true;
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_AsyncFlowCall.FlowOutput> outputs = 
            mf_FlowUtils_AsyncFlowCall.callFlow(new List<mf_FlowUtils_AsyncFlowCall.FlowInput>{input});
        Test.stopTest();
        
        // Verify output
        System.assertEquals(1, outputs.size());
        System.assertEquals(true, outputs[0].success);
        System.assertEquals('Flow queued for asynchronous execution', outputs[0].message);
    }
    
    /**
     * @description Test with missing flow name
     */
    @isTest
    static void testCallFlow_MissingFlowName() {
        // Create test input with no flow name
        mf_FlowUtils_AsyncFlowCall.FlowInput input = new mf_FlowUtils_AsyncFlowCall.FlowInput();
        input.flowName = null;
        input.jsonString = '{"test": "data"}';
        input.isSignal = false;
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_AsyncFlowCall.FlowOutput> outputs = 
            mf_FlowUtils_AsyncFlowCall.callFlow(new List<mf_FlowUtils_AsyncFlowCall.FlowInput>{input});
        Test.stopTest();
        
        // Verify error handling
        System.assertEquals(1, outputs.size());
        System.assertEquals(false, outputs[0].success);
        System.assertEquals('Flow name is required', outputs[0].message);
    }
    
    /**
     * @description Test with empty JSON string
     */
    @isTest
    static void testCallFlow_EmptyJson() {
        // Create test input with empty JSON
        mf_FlowUtils_AsyncFlowCall.FlowInput input = new mf_FlowUtils_AsyncFlowCall.FlowInput();
        input.flowName = 'Test_Flow_Name';
        input.jsonString = '';
        input.isSignal = false;
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_AsyncFlowCall.FlowOutput> outputs = 
            mf_FlowUtils_AsyncFlowCall.callFlow(new List<mf_FlowUtils_AsyncFlowCall.FlowInput>{input});
        Test.stopTest();
        
        // Verify output
        System.assertEquals(1, outputs.size());
        System.assertEquals(true, outputs[0].success);
    }
    
    /**
     * @description Test with null isSignal value
     */
    @isTest
    static void testCallFlow_NullSignal() {
        // Create test input with null isSignal
        mf_FlowUtils_AsyncFlowCall.FlowInput input = new mf_FlowUtils_AsyncFlowCall.FlowInput();
        input.flowName = 'Test_Flow_Name';
        input.jsonString = '{"data": "test"}';
        input.isSignal = null;
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_AsyncFlowCall.FlowOutput> outputs = 
            mf_FlowUtils_AsyncFlowCall.callFlow(new List<mf_FlowUtils_AsyncFlowCall.FlowInput>{input});
        Test.stopTest();
        
        // Verify output
        System.assertEquals(1, outputs.size());
        System.assertEquals(true, outputs[0].success);
    }
    
    /**
     * @description Test with multiple inputs
     */
    @isTest
    static void testCallFlow_MultipleInputs() {
        List<mf_FlowUtils_AsyncFlowCall.FlowInput> inputs = new List<mf_FlowUtils_AsyncFlowCall.FlowInput>();
        
        // First input
        mf_FlowUtils_AsyncFlowCall.FlowInput input1 = new mf_FlowUtils_AsyncFlowCall.FlowInput();
        input1.flowName = 'Test_Flow_1';
        input1.jsonString = '{"test": 1}';
        input1.isSignal = true;
        inputs.add(input1);
        
        // Second input
        mf_FlowUtils_AsyncFlowCall.FlowInput input2 = new mf_FlowUtils_AsyncFlowCall.FlowInput();
        input2.flowName = 'Test_Flow_2';
        input2.jsonString = '{"test": 2}';
        input2.isSignal = false;
        inputs.add(input2);
        
        // Third input with missing flow name
        mf_FlowUtils_AsyncFlowCall.FlowInput input3 = new mf_FlowUtils_AsyncFlowCall.FlowInput();
        input3.flowName = '';
        input3.jsonString = '{"test": 3}';
        inputs.add(input3);
        
        // Execute method
        Test.startTest();
        List<mf_FlowUtils_AsyncFlowCall.FlowOutput> outputs = 
            mf_FlowUtils_AsyncFlowCall.callFlow(inputs);
        Test.stopTest();
        
        // Verify outputs
        System.assertEquals(3, outputs.size());
        System.assertEquals(true, outputs[0].success);
        System.assertEquals(true, outputs[1].success);
        System.assertEquals(false, outputs[2].success);
    }
}