({
    fetchTourist : function (component) {        
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
    
    createTable: function (component) {
        component.set('v.touristColumns', [
            {label: 'Tourist Name', fieldName: 'linkName', type: 'url',
             typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}},
            {label: 'Email', fieldName: 'Email__c', type: 'Email'},
            {label: 'Age', fieldName: 'Age__c', type: 'Number'},
            {label: 'Gender', fieldName: 'Gender__c', type: 'Text'}
        ]);
    },
        
    showToast: function (title, message, type) {
       const toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title" : title,
            "type" : type,
            "message" : message
        });
        toastEvent.fire();
    },
});