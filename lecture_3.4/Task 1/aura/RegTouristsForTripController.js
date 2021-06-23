({    
    doInit : function(component, event, helper) {        
        helper.fetchTourist(component, event);
        helper.createTable(component, event);
    },
    
    componentUpdate: function(component, event, helper) {
        helper.fetchTourist(component, event);
        const countFreeSeats = component.get('v.simpleRecord.Number_Free_Seats__c');
        const startDate = component.get('v.simpleRecord.Start_Date__c');                
        const today = $A.localizationService.formatDate(new Date(), 'YYYY-MM-DD');
        //const openService = (countFreeSeats >= 0 && today < startDate && !(Array.isArray(tourists) && !tourists.length));
        const openService = (countFreeSeats <= 0 || today > startDate);
        component.set("v.openService", !openService);
        component.set("v.closeService", openService);
    },
    
    getSelectedName: function (component, event) {
        const selectedTourists = component.find("touristTable").getSelectedRows();
        component.set("v.selectedTourists", selectedTourists);
        const ids = selectedTourists.map(tourist => tourist.Id);
        component.set('v.selectedTouristsIds', ids);
    },
    
    clickCreate : function (component, event, helper) {        
        const numberSelectedTourists = component.get('v.selectedTouristsIds').length;        
        const countFreeSeats = component.get('v.simpleRecord.Number_Free_Seats__c');
        if (numberSelectedTourists == 0 || numberSelectedTourists > countFreeSeats) {
            const title = $A.get("$Label.c.Error");
            const message = $A.get("$Label.c.flightsCreatedError");
            const type = 'error'
            helper.showToast(title, message, type);
        }else {
            component.set("v.showModal", true);
        }
    },
    
    handleYes : function(component, event, helper) {
        const hideModal = component.get('v.showModal');
        const action = component.get('c.createFlights');
        action.setParams({
            touristIds: component.get('v.selectedTouristsIds'),
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
        const title = $A.get("$Label.c.Successfully");
            const message = $A.get("$Label.c.flightsCreatedSuccessfully");
            const type = 'success'
            helper.showToast(title, message, type);        
    },
    
    handleNo : function(component) {
        const showModal = component.get('v.showModal');
        component.set('v.showModal', !showModal);
    },    
    
    showSpinner: function(component) {
        component.set("v.showSpinner", true); 
    },
    
    hideSpinner : function(component){  
        component.set("v.showSpinner", false);
    }
})