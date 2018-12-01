import ballerina/grpc;
import ballerina/io;

public type ChatClient client object {
    private grpc:Client grpcClient = new;
    private grpc:ClientEndpointConfig config = {};
    private string url;

    function __init(string url, grpc:ClientEndpointConfig? config = ()) {
        self.config = config ?: {};
        self.url = url;
        // Initialize client endpoint.
        grpc:Client c = new;
        c.init(self.url, self.config);
        error? result = c.initStub("non-blocking", ROOT_DESCRIPTOR, getDescriptorMap());
        if (result is error) {
            panic result;
        } else {
            self.grpcClient = c;
        }
    }


    remote function chat(service msgListener, grpc:Headers? headers = ()) returns (grpc:StreamingClient|error)  {
        return self.grpcClient->streamingExecute("Chat/chat", msgListener, headers = headers);
    }
};

type ChatMessage record {
    string name;
    string message;

};



const string ROOT_DESCRIPTOR = "0A22677270635F6269646972656374696F6E616C5F73747265616D696E672E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F223B0A0B436861744D65737361676512120A046E616D6518012001280952046E616D6512180A076D65737361676518022001280952076D657373616765323E0A044368617412360A0463686174120C2E436861744D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756528013001620670726F746F33";
function getDescriptorMap() returns map<string> {
    return {
        "grpc_bidirectional_streaming.proto":
        "0A22677270635F6269646972656374696F6E616C5F73747265616D696E672E70726F746"
        + "F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F223B"
        + "0A0B436861744D65737361676512120A046E616D6518012001280952046E616D65121"
        + "80A076D65737361676518022001280952076D657373616765323E0A04436861741236"
        + "0A0463686174120C2E436861744D6573736167651A1C2E676F6F676C652E70726F746"
        + "F6275662E537472696E6756616C756528013001620670726F746F33",
        "google/protobuf/wrappers.proto":
        "0A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F120F676"
        + "F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A057661"
        + "6C7565180120012801520576616C756522220A0A466C6F617456616C756512140A057"
        + "6616C7565180120012802520576616C756522220A0A496E74363456616C756512140A"
        + "0576616C7565180120012803520576616C756522230A0B55496E74363456616C75651"
        + "2140A0576616C7565180120012804520576616C756522220A0A496E74333256616C75"
        + "6512140A0576616C7565180120012805520576616C756522230A0B55496E743332566"
        + "16C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56"
        + "616C756512140A0576616C7565180120012808520576616C756522230A0B537472696"
        + "E6756616C756512140A0576616C7565180120012809520576616C756522220A0A4279"
        + "74657356616C756512140A0576616C756518012001280C520576616C756542570A136"
        + "36F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50"
        + "015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F62756"
        + "62E57656C6C4B6E6F776E5479706573620670726F746F33"

    };
}

