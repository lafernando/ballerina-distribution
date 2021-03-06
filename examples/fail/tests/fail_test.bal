import ballerina/test;

string[] outputs = [];

// This is the mock function that replaces the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any|error... val) {
    outputs.push(toString(val.reduce(function (any|error a, any|error b) returns string => toString(a) + toString(b), "")));
}

function toString(any|error val) returns string => val is error? val.toString() : val.toString();

@test:Config {}
function testFunc() {
    test:when(mock_printLn).call("mockPrint");

    // Invoke the main function.
    main();
    test:assertEquals(outputs[0], "Error returned:InvalidAccountID");
    test:assertEquals(outputs[1], "Error returned:AccountNotFound");
}
