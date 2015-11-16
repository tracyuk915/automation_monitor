var app = app || {};

// The Application
// ---------------

// Our overall **AppView** is the top-level piece of UI.
app.AppView = Backbone.View.extend({

    // Instead of generating a new element, bind to the existing skeleton of
    // the App already present in the HTML.
    el: '#app',

    // Our template for the line of statistics at the bottom of the app.
    statsTemplate: _.template( $('#stats-template').html() ),

    // At initialization we bind to the relevant events on the `Todos`
    // collection, when items are added or changed.
    initialize: function() {
        this.allCheckbox = this.$('#toggle-all')[0];

        this.listenTo(app.AutomationSets, 'add', this.addOne);
        this.listenTo(app.AutomationSets, 'reset', this.addAll);
    },

    // Add a single todo item to the list by creating a view for it, and
    // appending its element to the `<ul>`.
    addOne: function( todo ) {
        var view = new app.AutomationSetEditView({ model: todo });
        $('#todo-list').append( view.render().el );
    },

    // Add all items in the **Todos** collection at once.
    addAll: function() {
        this.$('#todo-list').html('');
        app.Todos.each(this.addOne, this);
    }

});