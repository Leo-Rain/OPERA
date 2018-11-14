function J_2 = fcnJ_2(x_m, y_m, z_m, xi_1, xi_3, C, D_LE, E, D_TE)
t2 = (C .* x_m + D_LE - y_m);
t4 = abs(z_m);
t5 = t4 .* C;
t7 = x_m + z_m;
t10 = x_m - z_m;
t13 = (C .* t10 + D_LE - y_m) .* (C .* t7 + D_LE - y_m);
t15 = sqrt(2.*i .* t5 .* t2 + t13);
t16 = 0.1e1 ./ t15;
t19 = C .^ 2;
t20 = (xi_1 .^ 2);
t22 = y_m - D_LE;
t26 = x_m .^ 2;
t28 = 2 .* x_m .* xi_1;
t29 = y_m .^ 2;
t31 = 2 .* D_LE .* y_m;
t32 = z_m .^ 2;
t33 = D_LE .^ 2;
t35 = sqrt((-2 .* C .* t22 .* xi_1 + t20 .* t19 + t20 + t26 - t28 + t29 - t31 + t32 + t33));
t37 = sqrt((t19 + 1));
t39 = t19 .* xi_1;
t41 = -C .* t22;
t43 = log(t37 .* t35 + t39 + t41 - x_m + xi_1);
t44 = (xi_3 .^ 2);
t50 = 2 .* x_m .* xi_3;
t52 = sqrt((-2 .* C .* t22 .* xi_3 + t44 .* t19 + t26 + t29 - t31 + t32 + t33 + t44 - t50));
t54 = t19 .* xi_3;
t56 = log(t37 .* t52 + t41 + t54 - x_m + xi_3);
t60 = t4 .* x_m;
t61 = t26 ./ 0.2e1;
t62 = t32 ./ 0.2e1;
t63 = i .* t60 + t61 - t62;
t65 = -i .* t15;
t69 = -i .* x_m;
t70 = t39 .* t69;
t71 = x_m + xi_1;
t73 = C .* t22 .* t71;
t74 = -i .* t29;
t76 = 2.*i .* D_LE .* y_m;
t77 = -i .* t32;
t78 = -i .* t33;
t80 = -i .* xi_1;
t82 = 0.1e1 ./ (-t4 + i .* x_m + t80);
t84 = log(t82 .* (t35 .* t65 + (t4 .* (t39 + t41 - x_m + xi_1)) + t70 + i .* t73 + t74 + t76 + t77 + t78));
t88 = -i .* xi_3;
t90 = t19 .* x_m .* t88;
t91 = x_m + xi_3;
t93 = C .* t22 .* t91;
t96 = 0.1e1 ./ (-t4 + i .* x_m + t88);
t98 = log(t96 .* (t52 .* t65 + (t4 .* (t54 + t41 - x_m + xi_3)) + t90 + i .* t93 + t74 + t76 + t77 + t78));
t99 = t84 - t98;
t105 = sqrt(-2.*i .* t5 .* t2 + t13);
t107 = -i .* t105;
t109 = C .* t22;
t114 = 0.1e1 ./ (t4 + i .* x_m + t80);
t116 = log(t114 .* (t35 .* t107 + (t4 .* (-t39 + t109 + x_m - xi_1)) + t70 + i .* t73 + t74 + t76 + t77 + t78));
t122 = 0.1e1 ./ (t4 + i .* x_m + t88);
t124 = log(t122 .* (t52 .* t107 + (t4 .* (-t54 + t109 + x_m - xi_3)) + t90 + i .* t93 + t74 + t76 + t77 + t78));
t125 = t116 - t124;
t127 = i .* t60 - t61 + t62;
t132 = 0.1e1 ./ t105;
t135 = 1 ./ t4;
t141 = i .* t4 + x_m;
t144 = i .* t4 - x_m;
t148 = -t105 .* t141 .* t99 - t125 .* t144 .* t15;
t154 = E .* x_m + D_TE - y_m;
t156 = t4 .* E;
t162 = (E .* t7 + D_TE - y_m) .* (E .* t10 + D_TE - y_m);
t164 = sqrt(-2.*i .* t156 .* t154 + t162);
t165 = t164 .* t141;
t169 = sqrt(2.*i .* t156 .* t154 + t162);
t170 = -i .* t169;
t171 = E .^ 2;
t173 = -D_TE + y_m;
t178 = 2 .* D_TE .* y_m;
t179 = D_TE .^ 2;
t181 = sqrt((-2 .* E .* t173 .* xi_1 + t20 .* t171 - t178 + t179 + t20 + t26 - t28 + t29 + t32));
t183 = t171 .* xi_1;
t185 = -E .* t173;
t188 = t183 .* t69;
t190 = E .* t173 .* t71;
t192 = -i .* (t179 - t178 + t29 + t32);
t195 = log(t82 .* (t181 .* t170 + (t4 .* (t183 + t185 + xi_1 - x_m)) + t188 + i .* t190 + t192));
t202 = sqrt((-2 .* E .* t173 .* xi_3 + t44 .* t171 - t178 + t179 + t26 + t29 + t32 + t44 - t50));
t204 = t171 .* xi_3;
t207 = t204 .* t69;
t209 = E .* t173 .* t91;
t212 = log(t96 .* (t202 .* t170 + (t4 .* (t204 + t185 + xi_3 - x_m)) + t207 + i .* t209 + t192));
t215 = -i .* t164;
t217 = E .* t173;
t220 = -i .* t179;
t222 = 2.*i .* D_TE .* y_m;
t225 = log(t114 .* (t181 .* t215 + (t4 .* (-t183 + t217 - xi_1 + x_m)) + t188 + i .* t190 + t220 + t222 + t74 + t77));
t231 = log(t122 .* (t202 .* t215 + (t4 .* (-t204 + t217 - xi_3 + x_m)) + t207 + i .* t209 + t220 + t222 + t74 + t77));
t234 = t195 .* t165 - t212 .* t165 + (t225 - t231) .* t144 .* t169;
t236 = 0.1e1 ./ t169;
t237 = 0.1e1 ./ t164;
t244 = sqrt((t171 + 1));
t246 = t169 .* t244;
t253 = log(t244 .* t181 + t183 + t185 - x_m + xi_1);
t256 = log(t244 .* t202 + t185 + t204 - x_m + xi_3);
J_2 = i .* t135 ./ t37 .* t132 .* (t105 .* (-i .* t15 .* (t43 - t56) .* t4 + t99 .* t63 .* t37) + t127 .* t15 .* t125 .* t37) .* t16 .* C + -0.1e1 ./ 0.2e1.*i .* t135 .* t148 .* t132 .* t16 .* D_LE + -0.1e1 ./ 0.2e1.*i .* t135 .* t237 .* t236 .* t234 .* D_TE + i .* t135 .* (-t225 .* t127 .* t246 + t231 .* t127 .* t246 + (i .* t169 .* t4 .* (t253 - t256) + t63 .* (t212 - t195) .* t244) .* t164) ./ t244 .* t237 .* t236 .* E + 0.1e1 ./ 0.2e1.*i .* y_m .* t135 .* t148 .* t132 .* t16 + 0.1e1 ./ 0.2e1.*i .* y_m .* t135 .* t237 .* t236 .* t234;
end