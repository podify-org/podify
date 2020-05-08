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

    <img class="logo" src="../../assets/images/logo/navbar.png">
  </div>

  <aside class="sidebar" :class="{ active: active }">
    <ul class="top nav">
      <li class="nav-item">
        <a class="nav-link disabled">
          <strong>Feeds</strong>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link">
          All downloads
        </a>
      </li>
    </ul>

    <ul class="bottom nav">
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
      active: true,
    };
  },
  methods: {
    toggleSidebar() {
      this.active = !this.active;
    }
  }
}
</script>
