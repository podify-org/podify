<template>

<div>
  <div class="navbar navbar-dark fixed-top bg-dark">
    <button class="navbar-toggler"
            type="button"
            aria-controls="navbar-menu"
            aria-expanded="false"
            aria-label="Toggle navigation"
            @click="toggleSidebar()"
            >
      <span class="navbar-toggler-icon"></span>
    </button>

    <img class="logo" src="http://podify.localhost:3000/packs/media/logo/navbar-9431a977.png">
  </div>

  <aside class="sidebar" :class="{ active: active }">
    <ul class="nav flex-column">
      <li class="nav-item">
        <a class="nav-link" data-method="delete" href="/user/sign_out">
          Sign out
        </a>
      </li>
    </ul>
  </aside>
</div>

</template>

<script>
export default {
  data () {
    return {
      active: false,
    };
  },
  methods: {
    toggleSidebar() {
      this.active = !this.active;
    }
  }
}
</script>
