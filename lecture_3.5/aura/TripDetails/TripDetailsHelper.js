({	
    getSpacePoint : function (component) {        
        const action = component.get('c.getSpacePoint');
        action.setParams({            
            spacePointId: component.get('v.selectedTrip.Departure_Space_Point__c')
        });
        action.setCallback(this, function(response){
            const state = response.getState();           
            if (state === 'SUCCESS') {
                const records =response.getReturnValue();
                component.set('v.selectedSpacePoint', records);                
            }
        });
        $A.enqueueAction(action);       
    },
    
    getWeather : function(component) {        
        let action = component.get("c.getTemperature");
        action.setParams({
            tripId : component.get("v.selectedTrip.Id")
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