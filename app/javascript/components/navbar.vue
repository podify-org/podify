<template>

<div>
  <div class="navbar navbar-dark fixed-top bg-dark">
    <button class="navbar-toggler hamburger hamburger--arrow"
            :class="{ 'is-active': sidebarOpen }"
            type="button"
            aria-controls="sidebar"
            aria-expanded="false"
            aria-label="Toggle navigation"
            @click="toggleSidebar()"
            >
      <span class="hamburger-box">
        <span class="hamburger-inner"></span>
      </span>
    </button>

    <img class="logo" src="../../assets/images/logo/navbar.png">
  </div>

  <Sidebar :active="sidebarOpen"></Sidebar>
</div>

</template>

<script>
import Sidebar from 'components/sidebar';

export default {
  data () {
    return {
      sidebarOpen: Math.max(document.documentElement.clientWidth, window.innerWidth || 0) >= 1780,
    };
  },
  methods: {
    toggleSidebar() {
      this.sidebarOpen = !this.sidebarOpen;
    }
  },
  components: {
    Sidebar,
  },
}
</script>
