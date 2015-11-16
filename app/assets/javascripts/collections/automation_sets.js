var app = app || {};

var AutomationSetList = Backbone.Collection.extend({

    model: app.AutomationSet
});

app.AutomationSets = new AutomationSetList();