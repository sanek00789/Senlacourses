({
	fetchTrips : function (component, event) {
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
    
    fetchSpacePoint : function (component, event) {        
        const action = component.get('c.getTrip');
        action.setParams({            
            tripId: component.get('v.selectedTripId')
        });
        action.setCallback(this, function(response){
            const state = response.getState();            
            if (state === 'SUCCESS') {
                var records =response.getReturnValue();
                component.set('v.selectedTrip', records);                
            }
        });
        $A.enqueueAction(action);       
    },
    
    getWeather : function(component, event) {        
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
    }
})