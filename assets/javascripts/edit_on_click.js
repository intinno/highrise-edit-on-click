
var EditOnClick = Class.create({
    initialize: function(altId, contentId, wrapId) {
        this.altElement = $(altId);
        this.contentElement = $(contentId);
        this.wrapElement = $(wrapId);
        this.setupBehaviors();
    },

    // Sets up event handles for editable.
    setupBehaviors: function() {
        Event.observe(this.wrapElement, 'click', this.wrapClick.bindAsEventListener(this));
        this.contentElement.observe('change', this.contentChange.bindAsEventListener(this));
        Event.observe($(document.body), 'click', this.bodyClick.bindAsEventListener(this))
    },

    wrapClick: function(event){
      if (this.wrapElement.hasClassName('eoc-closed') == true) {
        this.hideUnchanged();
        this.altElement.hide();
        this.contentElement.show();
        this.wrapElement.removeClassName('eoc-closed');
        this.focusOnInput(this.contentElement);
      }
      Event.stop(event);
    },

    focusOnInput: function(element){
      inputElem = element.down('input');
      textareaElem = element.down('textarea');

      if (inputElem != null){
        inputElem.focus();
      } else if (textareaElem != null){
        textareaElem.focus();
      }
    },

    //content of the input has been changed. Now dont close the input
    contentChange: function() {
      this.contentElement.removeClassName('eoc-unchanged');
    },

    bodyClick: function() {
      this.hideUnchanged();
    },

    hideUnchanged : function(event) {
      var elems = $$('span.eoc-unchanged');
      for(var i = 0; i< elems.length; i++) {
        elem = elems[i];
        elemId = elem.id + "";
        altElemId = elemId.replace(/eoc_content_/, "eoc_alt_");
        altElem = $(altElemId);
        wrapElemId = elemId.replace(/eoc_content_/, "eoc_wrap_");
        wrapElem = $(wrapElemId);
        elem.hide();
        altElem.show();
        wrapElem.addClassName('eoc-closed');
      }
    }
});
