/* Cache only this app. External readings and media are never cached by Parcours. */
'use strict';
const CACHE='parcours-app-v1.1.1-cat';
const ASSETS=['./','./index.html','./manifest.webmanifest','./assets/icon-192.png','./assets/icon-512.png'];
self.addEventListener('install',event=>{event.waitUntil(caches.open(CACHE).then(cache=>cache.addAll(ASSETS)));self.skipWaiting();});
self.addEventListener('activate',event=>{event.waitUntil(caches.keys().then(names=>Promise.all(names.filter(n=>n.startsWith('parcours-app-')&&n!==CACHE).map(n=>caches.delete(n)))).then(()=>self.clients.claim()));});
self.addEventListener('fetch',event=>{const request=event.request,url=new URL(request.url);if(request.method!=='GET'||url.origin!==self.location.origin)return;
 if(request.mode==='navigate'){event.respondWith(fetch(request).then(response=>{if(response.ok){const copy=response.clone();event.waitUntil(caches.open(CACHE).then(cache=>cache.put('./index.html',copy)));}return response;}).catch(()=>caches.match('./index.html')));return;}
 event.respondWith(caches.match(request).then(cached=>cached||fetch(request)));
});
