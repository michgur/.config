"use strict";var i=Object.defineProperty;var l=Object.getOwnPropertyDescriptor;var p=Object.getOwnPropertyNames;var g=Object.prototype.hasOwnProperty;var m=(t,e)=>{for(var a in e)i(t,a,{get:e[a],enumerable:!0})},S=(t,e,a,u)=>{if(e&&typeof e=="object"||typeof e=="function")for(let r of p(e))!g.call(t,r)&&r!==a&&i(t,r,{get:()=>e[r],enumerable:!(u=l(e,r))||u.enumerable});return t};var D=t=>S(i({},"__esModule",{value:!0}),t);var h={};m(h,{default:()=>b});module.exports=D(h);var d=require("child_process");var n=require("@raycast/api"),s=require("node:child_process");async function f(t,e,a){e&&await(0,n.showHUD)(e),await o({menubar:!1,status:!1}),(0,s.exec)(`/usr/bin/caffeinate ${w(a)} || true`),await y(t,!0)}async function o(t,e){e&&await(0,n.showHUD)(e),(0,s.execSync)("/usr/bin/killall caffeinate || true"),await y(t,!1)}async function y(t,e){t.menubar&&await c("index",{caffeinated:e}),t.status&&await c("status",{caffeinated:e})}async function c(t,e){try{await(0,n.launchCommand)({name:t,type:n.LaunchType.Background,context:e})}catch{}}function w(t){let e=(0,n.getPreferenceValues)(),a=[];return e.preventDisplay&&a.push("d"),e.preventDisk&&a.push("m"),e.preventSystem&&a.push("i"),t&&a.push(` ${t}`),a.length>0?`-${a.join("")}`:""}var b=async()=>{try{(0,d.execSync)("pgrep caffeinate"),await o({menubar:!0,status:!0},"Your Mac is now decaffeinated")}catch{await f({menubar:!0,status:!0},"Your Mac is now caffeinated")}};
