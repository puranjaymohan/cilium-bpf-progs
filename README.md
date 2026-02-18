This repository contains a GitHub Actions job building the bpf programs from latest [cilium](https://github.com/cilium/cilium).

Built artifacts are published as releases in this repository. The releases are then used by CI system for testing Linux Kernel BPF (aka [BPF CI](https://github.com/kernel-patches/bpf/actions/workflows/test.yml)).

The CI system tests if the kernel patches cause regressions/improvements to the verification of these bpf programs.
