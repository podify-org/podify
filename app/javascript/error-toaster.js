const PROP_NAME = '$errorToaster';
const PROP_NAME_PRIV = '_errorToaster';

class ErrorToaster {
  constructor(vm, defaultOptions = {}) {
    this.vm = vm;

    this.defaultOptions = {
      title: 'Error',
      toaster: 'b-toaster-bottom-right',
      appendToast: true,
      variant: 'danger',
      solid: true,
      autoHideDelay: 5000,
      ...defaultOptions
    };
  };

  handle(payload, options = {}) {
    let message;

    if (Array.isArray(payload))
      message = payload.map(item => item.toString()).join(", ");
    else if (payload.hasOwnProperty('graphQLErrors'))
      message = payload.graphQLErrors.map(item => item.message).join(", ");
    else
      message = payload.toString();

    this.vm.$bvToast.toast(message, {
      ...this.defaultOptions,
      ...options,
    });
  };

  handler(options = {}) {
    return errors => this.handle(errors, options);
  }
}

export default (Vue, options) => {
  Vue.mixin({
    beforeCreate() {
      this._errorToaster = new ErrorToaster(this);
    },
  });

  Object.defineProperty(Vue.prototype, '$errorToaster', {
    get() {
      if (!this || !this._errorToaster) {
        console.error("$errorToaster must be accessed from a Vue instance 'this' context.");
      }
      return this._errorToaster;
    }
  });
};
