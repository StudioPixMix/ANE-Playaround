package com.studiopixmix.playaround;

import com.adobe.fre.FREContext;
import com.pft.playaroundsdk.InstallMessageDisplayedListener;
import com.pft.playaroundsdk.InstallMessageListener;
import com.studiopixmix.playaround.utils.FRELog;

public class PlayaroundInstallPromptListener implements InstallMessageListener {

	// PROPERTIES :
	/** The context used to dispatch the SHOULD_DISPLAY_CUSTOM_INSTALL_PROMPT event. */
	private FREContext context;
	/** The listener we should trigger the custom install prompt dialog callbacks onto. */
	private InstallMessageDisplayedListener listener;
	
	
	// CONSTRUCTOR :
	public PlayaroundInstallPromptListener(FREContext context) {
		this.context = context;
	}
	
	
	@Override
	public void displayInstallMessage(InstallMessageDisplayedListener listener) {
		FRELog.i("Playaround SDK requires to display a custom install prompt dialog, dispatching the corresponding event ...");
		this.listener = listener;
		context.dispatchStatusEventAsync(PlayaroundEvent.EVENT_SHOULD_DISPLAY_CUSTOM_INSTALL_PROMPT, "");
	}
	
	public void didAcceptInstall() {
		listener.didAcceptToInstallPlayAround();
	}
	
	public void didRefuseInstall() {
		listener.didRefuseToInstallPlayAround();
	}
	
	public void dispose() {
		context = null;
		listener = null;
	}

}
