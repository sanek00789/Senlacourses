({    
    doInit : function(component, event, helper) {        
        helper.fetchTourist(component, event);
		helper.getCountFreeSeats(component, event);
        helper.getStartDate(component, event);
        const countFreeSeats = component.get('v.countFreeSeats');
		const startDate = component.get('v.startDate');
        const closeService = component.get('v.closeService');
        const openService = component.get('v.openService');        
        const today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");        
        if (countFreeSeats <= 0 || today > startDate) {            
            component.set("v.openService", !openService);
            component.set("v.closeService", !closeService);
        }
    },
    
    getSelectedName: function (component, event) {
        const selectedRows = event.getParam('selectedRows');
        const selectedTourists = [];        
        selectedRows.forEach(function(selectedRow) {
            selectedTourists.push(selectedRow.Id);            
        })        
        component.set('v.selectedTouristsIds', selectedTourists); 
    },
    
    clickCreate : function (component, event, helper) {        
        const numberSelectedTourists = component.get('v.selectedTouristsIds').length;        
        const countFreeSeats = component.get('v.countFreeSeats');        
        if (numberSelectedTourists == 0 || numberSelectedTourists > countFreeSeats) {
            const toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title" : $A.get("$Label.c.Error"),
                "type" : "error",
                "duration" : "6000",
                "message" : $A.get("$Label.c.flightsCreatedError")
            });
            toastEvent.fire();
        }else {
            component.set("v.showModal", true);
        }
    },
    
    handleYes : function(component, event, helper) {
        const hideModal = component.get('v.showModal');
        const action = component.get('c.createFlights');
        action.setParams({
            touristsIds: component.get('v.selectedTouristsIds'),
            tripId: component.get('v.recordId')
        });
        action.setCallback(this, function(response){
            const state = response.getState();
            if (state === 'SUCCESS') {
                var records =response.getReturnValue();
            }
        });
        $A.enqueueAction(action);
        component.set('v.showModal', !hideModal);
        const toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title" : "Successfully ",
            "type" : "success",
            "message" : $A.get("$Label.c.flightsCreatedSuccessfully")
        });
        toastEvent.fire();
    },
    
    handleNo : function(component, event, helper) {
        const showModal = component.get('v.showModal');
        component.set('v.showModal', !showModal);
    },    
    
    showSpinner: function(component, event, helper) {
        component.set("v.showSpinner", true); 
    },
    
    hideSpinner : function(component,event,helper){  
        component.set("v.showSpinner", false);
    }
})