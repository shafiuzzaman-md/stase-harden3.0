; ModuleID = 'logger_dangling_combined.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.notifier_block = type { {}* }
%struct.notifier_block.0 = type { i32 (%struct.notifier_block.0*, i64, i8*)* }

@.str = private unnamed_addr constant [42 x i8] c"!( !module_alive && notifier_registered )\00", align 1
@.str.1 = private unnamed_addr constant [23 x i8] c"src/usb_event_logger.c\00", align 1
@__PRETTY_FUNCTION__.usb_logger_init = private unnamed_addr constant [26 x i8] c"int usb_logger_init(void)\00", align 1
@do_unregister = dso_local global i8 0, align 1, !dbg !0
@.str.2 = private unnamed_addr constant [14 x i8] c"do_unregister\00", align 1
@module_alive = dso_local global i8 0, align 1, !dbg !5
@.str.1.3 = private unnamed_addr constant [13 x i8] c"module_alive\00", align 1
@notifier_registered = dso_local global i8 0, align 1, !dbg !8
@.str.2.4 = private unnamed_addr constant [20 x i8] c"notifier_registered\00", align 1
@.str.4 = private unnamed_addr constant [57 x i8] c"module_alive == 1 && \22module should be alive after init\22\00", align 1
@.str.5 = private unnamed_addr constant [37 x i8] c"driver/klee_driver_dangling_notify.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [15 x i8] c"int main(void)\00", align 1
@.str.7 = private unnamed_addr constant [71 x i8] c"notifier_registered == 1 && \22notifier should be registered after init\22\00", align 1
@.str.9 = private unnamed_addr constant [56 x i8] c"module_alive == 0 && \22module should be dead after exit\22\00", align 1
@.str.11 = private unnamed_addr constant [89 x i8] c"notifier_registered == 0 && \22expected notifier to be unregistered when do_unregister==1\22\00", align 1
@.str.13 = private unnamed_addr constant [91 x i8] c"notifier_registered == 1 && \22expected notifier to remain registered when do_unregister==0\22\00", align 1
@usb_nb = dso_local global { i32 (%struct.notifier_block*, i64, i8*)* } { i32 (%struct.notifier_block*, i64, i8*)* @usb_notify }, align 8, !dbg !10
@.str.15 = private unnamed_addr constant [74 x i8] c"usb_nb.notifier_call == usb_notify && \22target callback identity mismatch\22\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @usb_notify(%struct.notifier_block* noundef %0, i64 noundef %1, i8* noundef %2) #0 !dbg !33 {
  %4 = alloca %struct.notifier_block*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i8*, align 8
  store %struct.notifier_block* %0, %struct.notifier_block** %4, align 8
  call void @llvm.dbg.declare(metadata %struct.notifier_block** %4, metadata !35, metadata !DIExpression()), !dbg !36
  store i64 %1, i64* %5, align 8
  call void @llvm.dbg.declare(metadata i64* %5, metadata !37, metadata !DIExpression()), !dbg !38
  store i8* %2, i8** %6, align 8
  call void @llvm.dbg.declare(metadata i8** %6, metadata !39, metadata !DIExpression()), !dbg !40
  %7 = load %struct.notifier_block*, %struct.notifier_block** %4, align 8, !dbg !41
  %8 = load i64, i64* %5, align 8, !dbg !42
  %9 = load i8*, i8** %6, align 8, !dbg !43
  ret i32 0, !dbg !44
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @usb_logger_init() #0 !dbg !45 {
  %1 = load i8, i8* @module_alive, align 1, !dbg !48
  %2 = trunc i8 %1 to i1, !dbg !48
  br i1 %2, label %6, label %3, !dbg !48

3:                                                ; preds = %0
  %4 = load i8, i8* @notifier_registered, align 1, !dbg !48
  %5 = trunc i8 %4 to i1, !dbg !48
  br i1 %5, label %7, label %6, !dbg !48

6:                                                ; preds = %3, %0
  br label %9, !dbg !48

7:                                                ; preds = %3
  %8 = call i32 (i8*, i8*, i32, i8*, ...) bitcast (i32 (...)* @__assert_fail to i32 (i8*, i8*, i32, i8*, ...)*)(i8* noundef getelementptr inbounds ([42 x i8], [42 x i8]* @.str, i64 0, i64 0), i8* noundef getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i64 0, i64 0), i32 noundef 30, i8* noundef getelementptr inbounds ([26 x i8], [26 x i8]* @__PRETTY_FUNCTION__.usb_logger_init, i64 0, i64 0)), !dbg !48
  br label %9, !dbg !48

9:                                                ; preds = %7, %6
  %10 = call i32 @usb_register_notify(%struct.notifier_block* noundef bitcast ({ i32 (%struct.notifier_block*, i64, i8*)* }* @usb_nb to %struct.notifier_block*)), !dbg !49
  store i8 1, i8* @notifier_registered, align 1, !dbg !50
  store i8 1, i8* @module_alive, align 1, !dbg !51
  ret i32 0, !dbg !52
}

; Function Attrs: noreturn
declare i32 @__assert_fail(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @usb_register_notify(%struct.notifier_block* noundef %0) #0 !dbg !53 {
  %2 = alloca %struct.notifier_block*, align 8
  store %struct.notifier_block* %0, %struct.notifier_block** %2, align 8
  call void @llvm.dbg.declare(metadata %struct.notifier_block** %2, metadata !56, metadata !DIExpression()), !dbg !57
  %3 = load %struct.notifier_block*, %struct.notifier_block** %2, align 8, !dbg !58
  ret i32 0, !dbg !59
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @usb_logger_exit() #0 !dbg !60 {
  %1 = load i8, i8* @do_unregister, align 1, !dbg !63
  %2 = trunc i8 %1 to i1, !dbg !63
  br i1 %2, label %3, label %5, !dbg !65

3:                                                ; preds = %0
  %4 = call i32 @usb_unregister_notify(%struct.notifier_block* noundef bitcast ({ i32 (%struct.notifier_block*, i64, i8*)* }* @usb_nb to %struct.notifier_block*)), !dbg !66
  store i8 0, i8* @notifier_registered, align 1, !dbg !68
  br label %5, !dbg !69

5:                                                ; preds = %3, %0
  store i8 0, i8* @module_alive, align 1, !dbg !70
  ret void, !dbg !71
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @usb_unregister_notify(%struct.notifier_block* noundef %0) #0 !dbg !72 {
  %2 = alloca %struct.notifier_block*, align 8
  store %struct.notifier_block* %0, %struct.notifier_block** %2, align 8
  call void @llvm.dbg.declare(metadata %struct.notifier_block** %2, metadata !73, metadata !DIExpression()), !dbg !74
  %3 = load %struct.notifier_block*, %struct.notifier_block** %2, align 8, !dbg !75
  ret i32 0, !dbg !76
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !77 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @klee_make_symbolic(i8* noundef @do_unregister, i64 noundef 1, i8* noundef getelementptr inbounds ([14 x i8], [14 x i8]* @.str.2, i64 0, i64 0)), !dbg !78
  call void @klee_make_symbolic(i8* noundef @module_alive, i64 noundef 1, i8* noundef getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1.3, i64 0, i64 0)), !dbg !79
  call void @klee_make_symbolic(i8* noundef @notifier_registered, i64 noundef 1, i8* noundef getelementptr inbounds ([20 x i8], [20 x i8]* @.str.2.4, i64 0, i64 0)), !dbg !80
  %2 = load i8, i8* @module_alive, align 1, !dbg !81
  %3 = trunc i8 %2 to i1, !dbg !81
  %4 = zext i1 %3 to i32, !dbg !81
  %5 = icmp eq i32 %4, 0, !dbg !82
  %6 = zext i1 %5 to i32, !dbg !82
  %7 = sext i32 %6 to i64, !dbg !81
  call void @klee_assume(i64 noundef %7), !dbg !83
  %8 = load i8, i8* @notifier_registered, align 1, !dbg !84
  %9 = trunc i8 %8 to i1, !dbg !84
  %10 = zext i1 %9 to i32, !dbg !84
  %11 = icmp eq i32 %10, 0, !dbg !85
  %12 = zext i1 %11 to i32, !dbg !85
  %13 = sext i32 %12 to i64, !dbg !84
  call void @klee_assume(i64 noundef %13), !dbg !86
  %14 = call i32 @usb_logger_init(), !dbg !87
  %15 = load i8, i8* @module_alive, align 1, !dbg !88
  %16 = trunc i8 %15 to i1, !dbg !88
  %17 = zext i1 %16 to i32, !dbg !88
  %18 = icmp eq i32 %17, 1, !dbg !88
  br i1 %18, label %19, label %21, !dbg !88

19:                                               ; preds = %0
  br i1 true, label %20, label %21, !dbg !88

20:                                               ; preds = %19
  br label %23, !dbg !88

21:                                               ; preds = %19, %0
  %22 = call i32 (i8*, i8*, i32, i8*, ...) bitcast (i32 (...)* @__assert_fail to i32 (i8*, i8*, i32, i8*, ...)*)(i8* noundef getelementptr inbounds ([57 x i8], [57 x i8]* @.str.4, i64 0, i64 0), i8* noundef getelementptr inbounds ([37 x i8], [37 x i8]* @.str.5, i64 0, i64 0), i32 noundef 37, i8* noundef getelementptr inbounds ([15 x i8], [15 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)), !dbg !88
  br label %23, !dbg !88

23:                                               ; preds = %21, %20
  %24 = load i8, i8* @notifier_registered, align 1, !dbg !89
  %25 = trunc i8 %24 to i1, !dbg !89
  %26 = zext i1 %25 to i32, !dbg !89
  %27 = icmp eq i32 %26, 1, !dbg !89
  br i1 %27, label %28, label %30, !dbg !89

28:                                               ; preds = %23
  br i1 true, label %29, label %30, !dbg !89

29:                                               ; preds = %28
  br label %32, !dbg !89

30:                                               ; preds = %28, %23
  %31 = call i32 (i8*, i8*, i32, i8*, ...) bitcast (i32 (...)* @__assert_fail to i32 (i8*, i8*, i32, i8*, ...)*)(i8* noundef getelementptr inbounds ([71 x i8], [71 x i8]* @.str.7, i64 0, i64 0), i8* noundef getelementptr inbounds ([37 x i8], [37 x i8]* @.str.5, i64 0, i64 0), i32 noundef 38, i8* noundef getelementptr inbounds ([15 x i8], [15 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)), !dbg !89
  br label %32, !dbg !89

32:                                               ; preds = %30, %29
  call void @usb_logger_exit(), !dbg !90
  %33 = load i8, i8* @module_alive, align 1, !dbg !91
  %34 = trunc i8 %33 to i1, !dbg !91
  %35 = zext i1 %34 to i32, !dbg !91
  %36 = icmp eq i32 %35, 0, !dbg !91
  br i1 %36, label %37, label %39, !dbg !91

37:                                               ; preds = %32
  br i1 true, label %38, label %39, !dbg !91

38:                                               ; preds = %37
  br label %41, !dbg !91

39:                                               ; preds = %37, %32
  %40 = call i32 (i8*, i8*, i32, i8*, ...) bitcast (i32 (...)* @__assert_fail to i32 (i8*, i8*, i32, i8*, ...)*)(i8* noundef getelementptr inbounds ([56 x i8], [56 x i8]* @.str.9, i64 0, i64 0), i8* noundef getelementptr inbounds ([37 x i8], [37 x i8]* @.str.5, i64 0, i64 0), i32 noundef 44, i8* noundef getelementptr inbounds ([15 x i8], [15 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)), !dbg !91
  br label %41, !dbg !91

41:                                               ; preds = %39, %38
  %42 = load i8, i8* @do_unregister, align 1, !dbg !92
  %43 = trunc i8 %42 to i1, !dbg !92
  br i1 %43, label %44, label %54, !dbg !94

44:                                               ; preds = %41
  %45 = load i8, i8* @notifier_registered, align 1, !dbg !95
  %46 = trunc i8 %45 to i1, !dbg !95
  %47 = zext i1 %46 to i32, !dbg !95
  %48 = icmp eq i32 %47, 0, !dbg !95
  br i1 %48, label %49, label %51, !dbg !95

49:                                               ; preds = %44
  br i1 true, label %50, label %51, !dbg !95

50:                                               ; preds = %49
  br label %53, !dbg !95

51:                                               ; preds = %49, %44
  %52 = call i32 (i8*, i8*, i32, i8*, ...) bitcast (i32 (...)* @__assert_fail to i32 (i8*, i8*, i32, i8*, ...)*)(i8* noundef getelementptr inbounds ([89 x i8], [89 x i8]* @.str.11, i64 0, i64 0), i8* noundef getelementptr inbounds ([37 x i8], [37 x i8]* @.str.5, i64 0, i64 0), i32 noundef 48, i8* noundef getelementptr inbounds ([15 x i8], [15 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)), !dbg !95
  br label %53, !dbg !95

53:                                               ; preds = %51, %50
  br label %64, !dbg !97

54:                                               ; preds = %41
  %55 = load i8, i8* @notifier_registered, align 1, !dbg !98
  %56 = trunc i8 %55 to i1, !dbg !98
  %57 = zext i1 %56 to i32, !dbg !98
  %58 = icmp eq i32 %57, 1, !dbg !98
  br i1 %58, label %59, label %61, !dbg !98

59:                                               ; preds = %54
  br i1 true, label %60, label %61, !dbg !98

60:                                               ; preds = %59
  br label %63, !dbg !98

61:                                               ; preds = %59, %54
  %62 = call i32 (i8*, i8*, i32, i8*, ...) bitcast (i32 (...)* @__assert_fail to i32 (i8*, i8*, i32, i8*, ...)*)(i8* noundef getelementptr inbounds ([91 x i8], [91 x i8]* @.str.13, i64 0, i64 0), i8* noundef getelementptr inbounds ([37 x i8], [37 x i8]* @.str.5, i64 0, i64 0), i32 noundef 50, i8* noundef getelementptr inbounds ([15 x i8], [15 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)), !dbg !98
  br label %63, !dbg !98

63:                                               ; preds = %61, %60
  br label %64

64:                                               ; preds = %63, %53
  %65 = load i32 (%struct.notifier_block.0*, i64, i8*)*, i32 (%struct.notifier_block.0*, i64, i8*)** getelementptr inbounds (%struct.notifier_block.0, %struct.notifier_block.0* bitcast ({ i32 (%struct.notifier_block*, i64, i8*)* }* @usb_nb to %struct.notifier_block.0*), i32 0, i32 0), align 8, !dbg !100
  %66 = icmp eq i32 (%struct.notifier_block.0*, i64, i8*)* %65, bitcast (i32 (%struct.notifier_block*, i64, i8*)* @usb_notify to i32 (%struct.notifier_block.0*, i64, i8*)*), !dbg !100
  br i1 %66, label %67, label %69, !dbg !100

67:                                               ; preds = %64
  br i1 true, label %68, label %69, !dbg !100

68:                                               ; preds = %67
  br label %71, !dbg !100

69:                                               ; preds = %67, %64
  %70 = call i32 (i8*, i8*, i32, i8*, ...) bitcast (i32 (...)* @__assert_fail to i32 (i8*, i8*, i32, i8*, ...)*)(i8* noundef getelementptr inbounds ([74 x i8], [74 x i8]* @.str.15, i64 0, i64 0), i8* noundef getelementptr inbounds ([37 x i8], [37 x i8]* @.str.5, i64 0, i64 0), i32 noundef 55, i8* noundef getelementptr inbounds ([15 x i8], [15 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)), !dbg !100
  br label %71, !dbg !100

71:                                               ; preds = %69, %68
  %72 = call i32 @usb_logger_init(), !dbg !101
  ret i32 0, !dbg !102
}

declare void @klee_make_symbolic(i8* noundef, i64 noundef, i8* noundef) #3

declare void @klee_assume(i64 noundef) #3

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { noreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!2, !23}
!llvm.ident = !{!25, !25}
!llvm.module.flags = !{!26, !27, !28, !29, !30, !31, !32}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "do_unregister", scope: !2, file: !3, line: 15, type: !7, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.6", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "src/usb_event_logger.c", directory: "/home/shafi/stase-harden3.0/usb_notifier_testsuite", checksumkind: CSK_MD5, checksum: "b1d5a635213c984ab931c44e05435773")
!4 = !{!5, !8, !10, !0}
!5 = !DIGlobalVariableExpression(var: !6, expr: !DIExpression())
!6 = distinct !DIGlobalVariable(name: "module_alive", scope: !2, file: !3, line: 11, type: !7, isLocal: false, isDefinition: true)
!7 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!8 = !DIGlobalVariableExpression(var: !9, expr: !DIExpression())
!9 = distinct !DIGlobalVariable(name: "notifier_registered", scope: !2, file: !3, line: 12, type: !7, isLocal: false, isDefinition: true)
!10 = !DIGlobalVariableExpression(var: !11, expr: !DIExpression())
!11 = distinct !DIGlobalVariable(name: "usb_nb", scope: !2, file: !3, line: 23, type: !12, isLocal: false, isDefinition: true)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "notifier_block", file: !13, line: 32, size: 64, elements: !14)
!13 = !DIFile(filename: "include/klee_kernel_stubs.h", directory: "/home/shafi/stase-harden3.0/usb_notifier_testsuite", checksumkind: CSK_MD5, checksum: "281395130d8c60f32d1bfb3409f8ef12")
!14 = !{!15}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "notifier_call", scope: !12, file: !13, line: 33, baseType: !16, size: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DISubroutineType(types: !18)
!18 = !{!19, !20, !21, !22}
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!21 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!23 = distinct !DICompileUnit(language: DW_LANG_C99, file: !24, producer: "Ubuntu clang version 14.0.6", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!24 = !DIFile(filename: "driver/klee_driver_dangling_notify.c", directory: "/home/shafi/stase-harden3.0/usb_notifier_testsuite", checksumkind: CSK_MD5, checksum: "83ac673096c2303e985942e2c63a6e3b")
!25 = !{!"Ubuntu clang version 14.0.6"}
!26 = !{i32 7, !"Dwarf Version", i32 5}
!27 = !{i32 2, !"Debug Info Version", i32 3}
!28 = !{i32 1, !"wchar_size", i32 4}
!29 = !{i32 7, !"PIC Level", i32 2}
!30 = !{i32 7, !"PIE Level", i32 2}
!31 = !{i32 7, !"uwtable", i32 1}
!32 = !{i32 7, !"frame-pointer", i32 2}
!33 = distinct !DISubprogram(name: "usb_notify", scope: !3, file: !3, line: 17, type: !17, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !34)
!34 = !{}
!35 = !DILocalVariable(name: "self", arg: 1, scope: !33, file: !3, line: 17, type: !20)
!36 = !DILocation(line: 17, column: 39, scope: !33)
!37 = !DILocalVariable(name: "action", arg: 2, scope: !33, file: !3, line: 17, type: !21)
!38 = !DILocation(line: 17, column: 59, scope: !33)
!39 = !DILocalVariable(name: "dev", arg: 3, scope: !33, file: !3, line: 17, type: !22)
!40 = !DILocation(line: 17, column: 73, scope: !33)
!41 = !DILocation(line: 19, column: 11, scope: !33)
!42 = !DILocation(line: 19, column: 23, scope: !33)
!43 = !DILocation(line: 19, column: 37, scope: !33)
!44 = !DILocation(line: 20, column: 5, scope: !33)
!45 = distinct !DISubprogram(name: "usb_logger_init", scope: !3, file: !3, line: 27, type: !46, scopeLine: 28, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !34)
!46 = !DISubroutineType(types: !47)
!47 = !{!19}
!48 = !DILocation(line: 30, column: 5, scope: !45)
!49 = !DILocation(line: 33, column: 5, scope: !45)
!50 = !DILocation(line: 36, column: 25, scope: !45)
!51 = !DILocation(line: 37, column: 18, scope: !45)
!52 = !DILocation(line: 38, column: 5, scope: !45)
!53 = distinct !DISubprogram(name: "usb_register_notify", scope: !13, file: !13, line: 40, type: !54, scopeLine: 40, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !34)
!54 = !DISubroutineType(types: !55)
!55 = !{!19, !20}
!56 = !DILocalVariable(name: "nb", arg: 1, scope: !53, file: !13, line: 40, type: !20)
!57 = !DILocation(line: 40, column: 62, scope: !53)
!58 = !DILocation(line: 41, column: 11, scope: !53)
!59 = !DILocation(line: 41, column: 15, scope: !53)
!60 = distinct !DISubprogram(name: "usb_logger_exit", scope: !3, file: !3, line: 41, type: !61, scopeLine: 42, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !34)
!61 = !DISubroutineType(types: !62)
!62 = !{null}
!63 = !DILocation(line: 44, column: 9, scope: !64)
!64 = distinct !DILexicalBlock(scope: !60, file: !3, line: 44, column: 9)
!65 = !DILocation(line: 44, column: 9, scope: !60)
!66 = !DILocation(line: 45, column: 9, scope: !67)
!67 = distinct !DILexicalBlock(scope: !64, file: !3, line: 44, column: 24)
!68 = !DILocation(line: 46, column: 29, scope: !67)
!69 = !DILocation(line: 47, column: 5, scope: !67)
!70 = !DILocation(line: 48, column: 18, scope: !60)
!71 = !DILocation(line: 49, column: 1, scope: !60)
!72 = distinct !DISubprogram(name: "usb_unregister_notify", scope: !13, file: !13, line: 43, type: !54, scopeLine: 43, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !34)
!73 = !DILocalVariable(name: "nb", arg: 1, scope: !72, file: !13, line: 43, type: !20)
!74 = !DILocation(line: 43, column: 64, scope: !72)
!75 = !DILocation(line: 44, column: 11, scope: !72)
!76 = !DILocation(line: 44, column: 15, scope: !72)
!77 = distinct !DISubprogram(name: "main", scope: !24, file: !24, line: 21, type: !46, scopeLine: 21, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !23, retainedNodes: !34)
!78 = !DILocation(line: 23, column: 3, scope: !77)
!79 = !DILocation(line: 27, column: 3, scope: !77)
!80 = !DILocation(line: 28, column: 3, scope: !77)
!81 = !DILocation(line: 29, column: 15, scope: !77)
!82 = !DILocation(line: 29, column: 28, scope: !77)
!83 = !DILocation(line: 29, column: 3, scope: !77)
!84 = !DILocation(line: 30, column: 15, scope: !77)
!85 = !DILocation(line: 30, column: 35, scope: !77)
!86 = !DILocation(line: 30, column: 3, scope: !77)
!87 = !DILocation(line: 34, column: 3, scope: !77)
!88 = !DILocation(line: 37, column: 3, scope: !77)
!89 = !DILocation(line: 38, column: 3, scope: !77)
!90 = !DILocation(line: 41, column: 3, scope: !77)
!91 = !DILocation(line: 44, column: 3, scope: !77)
!92 = !DILocation(line: 47, column: 7, scope: !93)
!93 = distinct !DILexicalBlock(scope: !77, file: !24, line: 47, column: 7)
!94 = !DILocation(line: 47, column: 7, scope: !77)
!95 = !DILocation(line: 48, column: 5, scope: !96)
!96 = distinct !DILexicalBlock(scope: !93, file: !24, line: 47, column: 22)
!97 = !DILocation(line: 49, column: 3, scope: !96)
!98 = !DILocation(line: 50, column: 5, scope: !99)
!99 = distinct !DILexicalBlock(scope: !93, file: !24, line: 49, column: 10)
!100 = !DILocation(line: 55, column: 3, scope: !77)
!101 = !DILocation(line: 59, column: 3, scope: !77)
!102 = !DILocation(line: 61, column: 3, scope: !77)
