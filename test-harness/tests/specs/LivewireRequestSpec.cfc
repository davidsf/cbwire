/*
{"serverMemo":{"checksum":"1ca298d9d162c7967d2313f76ba882d9bce208822308e04920c2080497c04fc1","data":{"message":"We have data binding!1"},"htmlHash":"71146cf2"},"effects":{"dirty":["count"],"html":"\n<div wire:id=\"3F1C0BD49178C76880E9D\">\n    <input type=\"text\" wire:model=\"message\">\n    <div>We have data binding!1</div>\n</div>\n"}}
*/
component extends="coldbox.system.testing.BaseTestCase" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll();
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		// all your suites go here.
		describe( "WireRequest", function(){
			beforeEach( function( currentSpec ){
				setup();
				event           = getRequestContext();
				livewireRequest = getInstance(
					name          = "cbwire.models.WireRequest",
					initArguments = { event : event }
				);
			} );

			it( "can be instantiated", function(){
				expect( isObject( livewireRequest ) ).toBeTrue();
			} );

			it( "can detect updates", function(){
				event.setValue( "updates", [] );
				expect( livewireRequest.hasUpdates() ).toBeFalse();
				event.setValue( "updates", [ {} ] );
				expect( livewireRequest.hasUpdates() ).toBeTrue();
			} );

			describe( "hydrateComponent", function(){
				it( "fires '$preHydrate' event", function(){
					var comp = prepareMock(
						getInstance(
							name          = "cbwire.models.Component",
							initArguments = { livewireRequest : livewireRequest }
						)
					);		
					comp.$( "$preHydrate", true );
					livewireRequest.hydrateComponent( comp );
					expect( comp.$once( "$preHydrate" ) ).toBeTrue();			
				} );

				it( "fires '$postHydrate' event", function(){
					var comp = prepareMock(
						getInstance(
							name          = "cbwire.models.Component",
							initArguments = { livewireRequest : livewireRequest }
						)
					);
					comp.$( "$preHydrate", true );		
					comp.$( "$postHydrate", true );
					livewireRequest.hydrateComponent( comp );
					expect( comp.$once( "$preHydrate" ) ).toBeTrue();	
					expect( comp.$once( "$postHydrate" ) ).toBeTrue();			
				} );
			} );

			describe( "getUpdates", function(){
				it( "can get updates", function(){
					event.setValue(
						"updates",
						[ { type : "callMethod" } ]
					);
					expect( livewireRequest.getUpdates() ).toBeArray();
					expect( arrayLen( livewireRequest.getUpdates() ) ).toBe( 1 );
					expect( livewireRequest.getUpdates()[1] ).toBeInstanceOf( "WireUpdate" );
				} );

				it( "returns type of callmethod", function(){
					event.setValue(
						"updates",
						[ { type : "callMethod" } ]
					);
					expect( livewireRequest.getUpdates() ).toBeArray();
					expect( arrayLen( livewireRequest.getUpdates() ) ).toBe( 1 );
					expect( livewireRequest.getUpdates()[1] ).toBeInstanceOf( "CallMethod" );
				} );

				it( "returns type of fireevent", function(){
					event.setValue(
						"updates",
						[ { type : "fireEvent" } ]
					);
					expect( livewireRequest.getUpdates() ).toBeArray();
					expect( arrayLen( livewireRequest.getUpdates() ) ).toBe( 1 );
					expect( livewireRequest.getUpdates()[1] ).toBeInstanceOf( "FireEvent" );
				} );

			} );

			it( "can detect fingerprint", function(){
				event.setValue( "fingerprint", { id : "" } );
				expect( livewireRequest.hasFingerprint() ).toBeTrue();
			} );

			it( "can detect serverMemo", function(){
				event.setValue( "serverMemo", {} );
				expect( livewireRequest.hasServerMemo() ).toBeTrue();
			} );

			it( "can get serverMemo", function(){
				event.setValue( "serverMemo", { checksum : "123" } );
				expect( livewireRequest.getServerMemo().checksum ).toBe( "123" );
			} );
		} );
	}

}
