<!--
  Usage:
```md
---
layout: four-cols-header
---
This shows up across both
::one::
# One
This shows on column one
::two::
# Two
This shows on column two
::three::
# Three
This shows on column three
::four::
# Four
This shows on column four
```
-->

<script setup lang="ts">
const props = defineProps({
  class: {
    type: String,
  },
})
</script>

<template>
  <div class="slidev-layout four-columns w-full h-full">
    <div class="col-span-4">
      <slot />
    </div>
    <div class="grid grid-cols-4 grid-rows-4">
      <div class="col-one" :class="props.class">
        <slot name="one" />
      </div>
      <div class="col-two" :class="props.class">
        <slot name="two" />
      </div>
      <div class="col-three" :class="props.class">
        <slot name="three" />
      </div>
      <div class="col-four" :class="props.class">
        <slot name="four" />
      </div>
    </div>
  </div>
</template>
