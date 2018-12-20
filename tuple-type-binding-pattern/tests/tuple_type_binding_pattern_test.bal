import ballerina/test;
import ballerina/io;

any[] outputs = [];
int counter = 0;

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any... s) {
    string outstr = "";
    foreach var str in s {
        outstr = outstr + io:sprintf("%s", str);
    }
    outputs[counter] = outstr;
    counter += 1;
}

@test:Config
function testFunc() {
    // Invoking the main function
    main();

    string out1 = "Simple variable : (true, 0.4)";
    string out2 = "Tuple variable : true0.4";
    string out3 = "Tuple variable : Ballerina46.7";
    string out4 = "Tuple variable : Ballerina34true6.7";
    string out5 = "Tuple variable : Ballerina3true345.645";
    string out6 = "Tuple variable : Ballerina123true";
    string out7 = "Tuple variable : Ballerina3true345.645";
    string out8 = "Tuple variable : Ballerina3.4456";

    test:assertEquals(outputs[0], out1);
    test:assertEquals(outputs[1], out2);
    test:assertEquals(outputs[2], out3);
    test:assertEquals(outputs[3], out4);
    test:assertEquals(outputs[4], out5);
    test:assertEquals(outputs[5], out6);
    test:assertEquals(outputs[6], out7);
    test:assertEquals(outputs[7], out8);
}
