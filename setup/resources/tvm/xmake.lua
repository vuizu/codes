package("tvm")
    add_deps("")

    set_homepage("https://tvm.apache.org/")
    set_description("An End to End Machine Learning Compiler Framework for CPUs, GPUs and accelerators")

    package:set("urls", "https://github.com/apache/tvm/releases/download/${version}/apache-tvm-src-${version}.tar.gz")
    package:add("version", "v0.17.0")
    package:add("version", "v0.16.0")

    on_load(function (package) 

    )

    on_install(function (package)
    
    )

    on_test(function (package) 
    
    )