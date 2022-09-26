package com.example.my_app


import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONArray


data class StepperData(
   val title: String,
   val description: String,
)

val stepperDataJson = """[{"title" : "Select Campaign settings", "description": "For each ad campaign that your create, you can control how much you are willing to spend on clicks and conversions, which networks and geographical locations you want your ads to shown on and more."}, 
    |{"title" : "Create ad group", "description": "For each ad campaign that your create, you can control how much you are willing to spend on clicks and conversions, which networks and geographical locations you want your ads to shown on and more."},
    |{"title" : "Create an ad", "description": "Try out diffrent ad text to see what brings in the most customers and learn how to enhcance your ads using features like ad extensions. If you run into any problems with your ads, find out how to tell if they are running and how to resolve approval issues."}
    |]""".trimMargin()


class MainActivity: FlutterActivity() {

    private val CHANNEL = "samples.flutter.dev/battery"
    val stepperData: MutableList<StepperData> = mutableListOf<StepperData>()

    val mutableList = mutableListOf(1, 3, 9, 16, 25)

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // This method is invoked on the main thread.
                call, result ->
            if (call.method == "getStepperData") {

                if (stepperDataJson != null) {
                    result.success(stepperDataJson)
                } else {
                    result.error("UNAVAILABLE", "Stepper Data not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }



}
