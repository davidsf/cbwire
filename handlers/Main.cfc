component {

	property name="cbwireRequest" inject="CBWireRequest@cbwire";

    /**
     * Primary entry point for cbwire requests after
     * initial component rendering.
     *
     * Currently uses /livewire URI to support LivewireJS.
     *
     * URI: /livewire/messages/:component
     */
    function index( event, rc, prc ){
        return variables.cbwireRequest.handle( arguments.rc );
    }

}
