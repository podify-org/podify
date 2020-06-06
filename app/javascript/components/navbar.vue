<template>

<div>
  <div class="navbar navbar-dark fixed-top bg-dark">
    <button class="navbar-toggler hamburger hamburger--arrow"
            :class="{ 'is-active': active }"
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

  <aside id="sidebar" class="sidebar" :class="{ active: active }">
    <FeedList :feeds="feeds"></FeedList>

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
import FeedList from 'components/feeds/list';

export default {
  data () {
    return {
      active: Math.max(document.documentElement.clientWidth, window.innerWidth || 0) >= 1780,
    };
  },
  computed: {
    feeds() { return this.$store.state.feeds; },
  },
  methods: {
    toggleSidebar() {
      this.active = !this.active;
    }
  },
  components: {
    FeedList
  },
}
</script>
