$(function(){


    var View = Backbone.View.extend({

        // Base the view on an existing element
        el: $('#backbone-container'),

        events: {
            "input #input":    "update",
            "click #send":      "send"
        },

        initialize: function() {
            this.listenTo(this.model, 'change', this.renderLabel);
        },

        update: function(event) {
            this.model.set("value", event.target.value);
            console.log(event.target.value, this.model.attributes);            
        },

        send: function() {
            console.log("Sending our value to elm...");
            elmView.ports.suggestions.send(this.model.get("value"));
        },

        template: _.template(
            '<div><input id="input"><button id="send">Send to Elm</button><div id="label"><%= value %></div></div>'
        ),

        render: function(){
            this.$el.html(this.template(this.model.attributes));
            return this;
        },

        // The fact that I need this is annoying, forgot about that stuff...
        // If I just re-render the full view on model change, the input is 
        // redrawn and I lose focus and the content in the input :(
        renderLabel: function(){
            this.$("#label").text(this.model.get("value"));
            return this;
        }
    });

    window.model = new Backbone.Model({value: "The Backbone model initial value"});

    window.view = new View({model: window.model});
    window.view.render();

    
});