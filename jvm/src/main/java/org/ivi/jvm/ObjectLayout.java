package org.ivi.jvm;

import org.openjdk.jol.info.ClassLayout;
import org.openjdk.jol.vm.VM;

public class ObjectLayout {
    public static void main(String[] args) {
        System.out.println(ClassLayout.parseInstance(new Object()).toPrintable());

        System.out.println(VM.current().objectAlignment());
        System.out.println(VM.current().details());
        System.out.println(VM.current().objectHeaderSize());
        System.out.println(VM.current().classPointerSize());
        System.out.println(VM.current().arrayHeaderSize());
        System.out.println(VM.current().addressSize());
    }
}
