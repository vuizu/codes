// 模块的名字随意更改
module module.basic {
    // 只有明确导入需要的模块，才能使用（如maven依赖）
    // 如果要像jdk8一样，则直接require java.se;
    // requires java.base;

    // static表示编译阶段需要该模块，但是运行时不需要
    // transitive表示开启引用传递，引用本模块，将一同引入java.logging
    requires static transitive java.logging;


    // SPI需要使用uses和provides with关键字
    // 使用uses关键字定义本模块需要的服务，需要通过自身或者其他模块实现
    uses org.ivi.spi.StorageFormatProvider;
    // 使用provides with关键字提供该接口的服务（实现）
    provides org.ivi.spi.StorageFormatProvider with
            org.ivi.spi.impl.ParquetFormat;
    // 如果需要其他模块实现，则需要使用exports关键字，将该接口所在的包导出
    // 所有的包都需要导出后，才能被别的模块访问
    exports org.ivi.spi to module.juc;

    // 直接在module关键字前面加open关键字，则该模块内容都可以使用反射访问
    // opens关键字则是对模块下的某个包开放反射访问，反射不存在传递效果
    opens org.ivi.spi to module.juc;
}