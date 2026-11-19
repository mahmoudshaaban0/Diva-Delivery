import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.limitlesscode.app_template.dev"
            resValue(type = "string", name = "app_name", value = "App Template Dev")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.limitlesscode.app_template"
            resValue(type = "string", name = "app_name", value = "App Template")
        }
    }

    buildFeatures.resValues = true
}