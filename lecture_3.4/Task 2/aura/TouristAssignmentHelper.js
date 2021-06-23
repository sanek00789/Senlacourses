({
	fetchTrips : function (component) {
        var url = $A.get('$Resource.TripImage');
        component.set('v.backgroundImageURL', url);
        const action = component.get('c.getTripsById');
        action.setParams({
            touristId: component.get('v.selectedId')
        });
        action.setCallback(this, function(response){
            const state = response.getState();
            if (state === 'SUCCESS') {
                const records =response.getReturnValue();                
                component.set('v.trips', records);
            }
        });
        $A.enqueueAction(action); 
    },    
    
    getSpacePoint : function (component, event) {        
        const action = component.get('c.getSpacePoint');
        action.setParams({            
            spacePointId: component.get('v.selectedTrip.Departure_Space_Point__c')
        });
        action.setCallback(this, function(response){
            const state = response.getState();            
            if (state === 'SUCCESS') {
                var records =response.getReturnValue();
                component.set('v.selectedSpacePoint', records);                
            }
        });
        $A.enqueueAction(action);       
    },
    
    getWeather : function(component) {        
        let action = component.get("c.getTemperature");
        action.setParams({
            tripId : component.get("v.selectedTripId")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.averageTemperature", response.getReturnValue().Average_Temperature__c);
            }             
        });
        $A.enqueueAction(action);
    },
    
    showToastSuccess: function (component) {
       const toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title" : $A.get("$Label.c.Successfully"),
            "type" : "success",
            "message" : $A.get("$Label.c.flightsCreatedSuccessfully")
        });
        toastEvent.fire();
    },
})