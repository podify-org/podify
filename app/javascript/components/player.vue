<template>
  <div>
    <div ref="container" class="player-container" :class="{ big: big, small: !big }" v-visible="visible">
      <video id="player"
             playsinline
             controls
             >
      </video>

      <div class="actions top right">
        <button v-if="big" @click="big = false" class="action"><i class="fas fa-chevron-down"></i></button>
        <button v-if="!big" @click="big = true" class="action"><i class="fas fa-chevron-up"></i></button>
        <button @click="close" class="action"><i class="fas fa-times"></i></button>
      </div>
    </div>

    <div v-show="visible && big" class="player-backdrop" @click="big = false"></div>
  </div>
</template>

<script>
import Plyr from 'plyr';
import Vue from 'vue';

export const state = Vue.observable({
  source: null,
});

export default {
  data() {
    return {
      visible: false,
      big: false,
    };
  },
  computed: {
    source() {
      return state.source;
    },
  },
  mounted() {
    const player = new Plyr('#player', {
      disableContextMenu: false,
      debug: false,
      controls: [
        'play-large', 'play', 'progress', 'current-time', 'mute', 'volume', 'captions', 'settings', 'pip', 'airplay', 'fullscreen'
      ],
    });
    player.on('loadedmetadata', this.updateAspectRatio);
    player.on('exitfullscreen', this.updateAspectRatio);
    window.addEventListener('resize', this.updateAspectRatio);
    window.player = player;
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.updateAspectRatio);
  },
  methods: {
    playSource(source) {
      this.visible = false;
      player.poster = this.source.thumbnailUrl;
      player.source = {
        type: 'video',
        sources: [
          {
            src: this.source.lastDownload.downloadUrl,
            type: 'video/mp4'
          },
        ],
      };
      this.big = true;
      this.visible = true;
      player.play();
    },
    updateAspectRatio() {
      let ratio = player.ratio;
      let height = null;
      if (ratio == null) {
        height = 53;
      } else {
        let dims = ratio
            .split(":")
            .map(s => parseInt(s))
        height = dims[1] / dims[0] * this.$refs.container.clientWidth;
      }
      this.$refs.container.style.height = height + "px";
      this.updatePosition();
    },
    updatePosition() {
      if (!this.visible || !this.big) return;

      let w = this.$refs.container.clientWidth;
      let h = this.$refs.container.clientHeight;

      this.$refs.container.style.marginLeft = `-${w / 2}px`;
      this.$refs.container.style.marginTop = `-${h / 2}px`;
    },
    close() {
      this.visible = false;
      player.stop();
      state.source = null;
    },
  },
  watch: {
    'source': {
      handler(val, oldVal) {
        this.playSource(val);
      }
    },
    'visible': {
      handler(val, oldVal) {
        this.updatePosition();
      }
    },
    'big': {
      handler(val, oldVal) {
        this.$nextTick(this.updateAspectRatio);
      }
    },
  },
}
</script>

<style scoped>
</style>
