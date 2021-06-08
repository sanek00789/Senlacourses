({
    
    fetchTourist : function(component, event, helper) {        
        component.set('v.mycolumns', [
            {label: 'Tourist Name', fieldName: 'linkName', type: 'url',
             typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}},
            {label: 'Gender', fieldName: 'Gender__c', type: 'Text'},
            {label: 'Age', fieldName: 'Age__c', type: 'Number'},
            {label: 'Birthdate', fieldName: 'Birthdate__c', type: 'Date'},
            {label: 'Email', fieldName: 'Email__c', type: 'Email'}
        ]);
        var action = component.get('c.getSuitableForTrip');
        action.setParams({
            recordId: component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var records =response.getReturnValue();
                records.forEach(function(record){
                    record.linkName = '/'+ record.Id;
                });
                component.set("v.tourists", records);
            }
        });
        $A.enqueueAction(action);
    },
    
    getSelectedName: function (component, event) {
        var selectedRows = event.getParam('selectedRows');
        var selectedTourists = [];
        
        selectedRows.forEach(function(selectedRow) {
            selectedTourists.push(selectedRow.Id);            
        })        
        component.set("v.selectedTouristsIds", selectedTourists); 
    },
    
    clickCreate : function (component, event, helper) {        
        var action = component.get('c.createFlights');
        action.setParams({
            touristsIds: component.get('v.selectedTouristsIds'),
            tripId: component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var records =response.getReturnValue();
            }
        });
        $A.enqueueAction(action);        
    }
})