package org.ivi;


public class NewFeatures {
    public static void main(String[] args) {
        // 集合通过of方法可以快速创建，都是不可变的（ImmutableCollections） -> jdk9

        // 在Stream.of(null)基础上新增Stream.ofNullable() -> jdk9

        // Stream.iterate(0, i -> i + 1).limit(20); -> 当不加limit时则无限生成下去
        // Stream.iterate(0, i -> i < 20, i -> i + 1); -> jdk9
        // Stream.iterate(0, i -> i + 1).takeWhile(i -> i < 20); -> 满足 < 20的 take，jdk9
        // Stream.iterate(0, i -> i + 1).dropWhile(i -> i < 20); -> 满足 < 20的 drop，jdk9

        // try-with-resource现在可以使用变量名代表完整声明 -> jdk9

        // Optional.of(null).ifPresentOrElse(); -> jdk9
        // Optional.of(null).or();

        // jdk10中只适用于局部变量的推断var和jdk13出现15开放的字符串模版
        var str = """
                hello\tworld
                    world
                """;

        // jdk11出现的操作String的新方法
        String k = "  a b\n  c";
        // k.isBlank();
        // k.lines(); 按换行符切分，并转换成Stream
        // k.strip(); 快速去掉首尾空格
        // k.repeat(2); 重复2次创建新字符串


        // jdk12出现，14开放的模式匹配
        int score = Integer.parseInt(args[0]);
        String msg = switch (score) {
            case 10, 9 -> "优秀";
            case 8, 7 -> "良好";
            case 6 -> "及格";
            default -> {
                System.out.println("进入到不及格中");
                // 使用yield返回，而不是return
                yield "不及格";
            }
        };

        // 强化版instanceof
        // cast("321");


        // class、interface、enum、@interface之后，新添一种类型record
        // 实质上是一个final类型，且继承自java.lang.Record抽象类的普通类
        // 在编译时，自动编译出get、equals等方法，但是没有set方法，因为一条记录不能改
        // A a = new A("123");

        // jdk17
        // 可以通过反射获取该类是否为密封类型
        System.out.println(Father.class.isSealed());
    }


    private static void cast(Object obj) {
        // 如果满足，则转为String并赋值给后面定义的变量
        if (obj instanceof String x) {
            System.out.println(x.equals("123"));
        }
    }

    private static final record A(String name) {
        public A() {
            this("haha");
        }

        // 就是成员字段必须定义在主构造器中
        static String o;

        void say() {

        }
    }

    // 通过密封类来限制类的继承，只许可Son1、Son2继承
    // 密封类必须要有一个子类
    static sealed class Father permits Son1, Son2 {
    }

    // 这里Son1不能再被继承了，封死了
    static final class Son1 extends Father {
    }

    // 这里Son2破坏了密封性，可以被任何类继承
    static non-sealed class Son2 extends Father {
    }
}
