# Custom

Ghost 3.1.1

## Update

core/frontend/helpers/navigation.js

```patch
diff --git a/core/frontend/helpers/navigation.js b/core/frontend/helpers/navigation.js
index fed5c02..1a887d1 100644
--- a/core/frontend/helpers/navigation.js
+++ b/core/frontend/helpers/navigation.js
@@ -79,8 +79,23 @@ module.exports = function navigation(options) {
         return out;
     });

+    // custom format navigation
+    var index = 0
+    var output_format = {}
+    _.each(output, function(nav) {
+        if (!nav.label.includes('=>')) {
+            index++
+            nav.items = []
+            output_format[index] = nav
+        } else {
+            nav.label = nav.label.replace('=>', '')
+            output_format[index].items.push(nav)
+        }
+    })
+    console.log(output_format)
+
     // CASE: The navigation helper should have access to the navigation items at the top level.
-    this.navigation = output;
+    this.navigation = output_format;
     // CASE: The navigation helper will forward attributes passed to it.
     _.merge(this, options.hash);
     const data = createFrame(options.data);
```