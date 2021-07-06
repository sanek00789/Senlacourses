({
	fetchTrips : function (component) {
        const url = $A.get('$Resource.TripImage');
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
    
    showToastSuccess: function (component) {
       const toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title" : $A.get("$Label.c.Successfully"),
            "type" : "success",
            "message" : $A.get("$Label.c.flightsCreatedSuccessfully")
        });
        toastEvent.fire();
    }
})