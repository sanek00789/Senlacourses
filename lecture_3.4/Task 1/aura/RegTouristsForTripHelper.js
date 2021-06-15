({
    fetchTourist : function (component, event) {
        component.set('v.mycolumns', [
            {label: 'Tourist Name', fieldName: 'linkName', type: 'url',
             typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}},
            {label: 'Email', fieldName: 'Email__c', type: 'Email'},
            {label: 'Age', fieldName: 'Age__c', type: 'Number'},
            {label: 'Gender', fieldName: 'Gender__c', type: 'Text'}
        ]);
        const action = component.get('c.getSuitableForTrip');
        action.setParams({
            tripId: component.get('v.recordId')
        });
        action.setCallback(this, function(response){
            const state = response.getState();
            if (state === 'SUCCESS') {
                const records =response.getReturnValue();
                records.forEach(function(record){
                    record.linkName = '/'+ record.Id;
                });
                component.set('v.tourists', records);
            }
        });
        $A.enqueueAction(action);        
    },
    
    getCountFreeSeats : function (component, event) {
        const action = component.get('c.countFreeSeats');
        action.setParams({            
            tripId: component.get('v.recordId')
        });
        action.setCallback(this, function(response){
            const state = response.getState();
            if (state === 'SUCCESS') {
                const records =response.getReturnValue();
                component.set('v.countFreeSeats', records);
            }
        });
        $A.enqueueAction(action);        
    },
    
    getStartDate : function(component, event) {
        const action = component.get("c.getStartDate");
        action.setParams({
            tripId : component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                const records = response.getReturnValue();
                component.set("v.startDate", records);
            }
        });
        $A.enqueueAction(action); 
    }
});