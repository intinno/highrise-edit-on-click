
var EditOnClick = Class.create({
    initialize: function(altId, contentId, wrapId) {
        this.altElement = $(altId);
        this.contentElement = $(contentId);
        this.wrapElement = $(wrapId);
        this.setupBehaviors();
    },

    // Sets up event handles for editable.
    setupBehaviors: function() {
        this.wrapElement.observe('click', this.wrapClick.bindAsEventListener(this));
        this.contentElement.observe('change', this.contentChange.bindAsEventListener(this));
        $(document.body).observe('click', this.bodyClick.bindAsEventListener(this))
    },

    wrapClick: function(event){
      if (this.wrapElement.hasClassName('eoc-closed') == true) {
        this.hideUnchanged();
        this.altElement.hide();
        this.contentElement.show();
        this.wrapElement.removeClassName('eoc-closed');
      }
      event.stop();
    },

    //content of the input has been changed. Now dont close the input
    contentChange: function() {
      this.contentElement.removeClassName('eoc-unchanged');
    },

    bodyClick: function() {
      this.hideUnchanged();
    },

    hideUnchanged : function(event) {
      $$('.eoc-unchanged').each(function(elem) {
        altElem = $(elem.id.replace(/eoc_content_/, "eoc_alt_"));
        wrapElem = $(elem.id.replace(/eoc_content_/, "eoc_wrap_"));
        elem.hide();
        altElem.show();
        wrapElem.addClassName('eoc-closed');
      });
    }
});
