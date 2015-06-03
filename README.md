Air Native Extension for PlayAround on iOS and Android (ARM and x86)
==================================

### General info :
- PlayAround Android SDK version : 0.2.2
- PlayAround iOS SDK version : 0.2.4
 
- Add this to your android manifest :

```xml
<android>
	<manifestAdditions><![CDATA[
		<manifest android:installLocation="auto">

			...

			<!-- PLAY AROUND -->
			<uses-permission android:name="android.permission.INTERNET"/>

			...
			
		</manifest>
	]]></manifestAdditions>
</android>
```
