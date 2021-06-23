({
    fetchTrips : function(component, event, helper) {
        component.set("v.showDetails", false);
        helper.fetchTrips(component, event)        
    },
    
    clickCreate : function (component, event, helper) {            
        component.set("v.showModal", true); 
    },
    
    getTripDetails : function (component, event, helper) {
        let selectedItem = event.currentTarget; // Get the target object
        let index = selectedItem.dataset.record; // Get its value i.e. the index
        let selectedTrip = component.get("v.trips")[index];
        component.set("v.selectedTrip", selectedTrip);
        component.set("v.selectedTripId", selectedTrip.Id);
        component.set('v.mapMarkers', [
            {
                location: {                    
                    City: selectedTrip.Name                    
                }
            }
        ]);
        helper.getWeather(component, event);
        component.set("v.showDetails", true);
        
    },
    
    handleYes : function(component, event, helper) {
        const hideModal = component.get('v.showModal');
        const action = component.get('c.createFlight');
        action.setParams({
            touristId: component.get('v.selectedId'),
            tripId: component.get('v.selectedTripId')
        });
        action.setCallback(this, function(response){
            const state = response.getState();
            if (state === 'SUCCESS') {
                var records =response.getReturnValue();
            }
        });
        $A.enqueueAction(action);
        component.set('v.showModal', !hideModal);
        helper.showToastSuccess(component);
    },
    
    handleNo : function(component, event, helper) {
        const showModal = component.get('v.showModal');
        component.set('v.showModal', !showModal);
    }
})