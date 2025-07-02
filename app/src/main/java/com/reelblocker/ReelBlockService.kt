package com.reelblocker

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityNodeInfo
import android.view.accessibility.AccessibilityEvent

class ReelBlockService : AccessibilityService() {

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event?.packageName != "com.instagram.android") {
            return
        }

        val root = rootInActiveWindow ?: return
        
        // More robust check for Reels. The tab might have content description "Reels"
        // and be selected. Or a view with text "Reels and short videos".
        if (isReelsOpen(root)) {
            performGlobalAction(GLOBAL_ACTION_HOME)
        }
        
        root.recycle()
    }

    private fun isReelsOpen(rootNode: AccessibilityNodeInfo): Boolean {
        return findNode(rootNode) != null
    }

    private fun findNode(node: AccessibilityNodeInfo?): AccessibilityNodeInfo? {
        if (node == null) return null

        // Check for "Reels" tab, which is often a selected button with content description.
        if (node.contentDescription?.contains("Reels", ignoreCase = true) == true && (node.isCheckable || node.isClickable)) {
             if (node.isFocused || node.isSelected) return node
        }
        
        // Fallback check for text view containing "Reels"
        if (node.text?.contains("Reels", ignoreCase = true) == true) {
            return node
        }

        for (i in 0 until node.childCount) {
            val child = node.getChild(i)
            val found = findNode(child)
            if (found != null) {
                // Don't recycle child if it's the one we are returning
                return found
            }
            child?.recycle()
        }

        return null
    }


    override fun onInterrupt() {
        // This method is called when the service is interrupted, for example,
        // when the user turns it off in the settings.
    }

    override fun onServiceConnected() {
        super.onServiceConnected()
        // You can add any setup logic here that needs to run when the service is connected.
        // For example, log that the service has started.
    }
}
