component extends="cbwire.models.Component" {

    // Data properties
    variables.data = {
        "timestamp" : now(),
        "myQuery" : ""
    };

    // Computed properties
    variables.$computed = {
        "myTimestamp" : function(){
            return variables.data.timestamp;
        }
    }

    function renderIt(){
        return this.renderView( "_wires/computedProperty" );
    }

}
