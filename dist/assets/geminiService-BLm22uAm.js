const O="https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent",G=o=>!o||o.length===0?"No hay diagramas de Ishikawa.":o.map((a,i)=>{const t=a.problem||"Problema no definido",p=Object.entries(a.categories||{}).map(([c,n])=>{if(!n||n.length===0)return null;const u=n.map(m=>{const E=typeof m=="string"?m:m.text,l=m.color==="green"?"(SI OCURRE)":m.color==="red"?"(NO OCURRE)":"";return`      - ${E} ${l}`}).join(`
`);return`    * ${c}:
${u}`}).filter(Boolean).join(`
`);return`  Diagrama #${i+1}: Problema: "${t}"
    Causa Raíz Seleccionada: ${a.rootCause||"Ninguna"}
${p}`}).join(`

`),J=o=>!o||o.length===0?"No hay análisis de 5 Porqués.":o.map((a,i)=>{const t=(a.whys||[]).filter(c=>c.trim().length>0).join(" -> "),p=a.status==="root"?"(CAUSA RAÍZ)":a.status==="discarded"?"(DESCARTADO)":"";return`  Análisis #${i+1}: ${a.problem}
    Cadena: ${t} ${p}`}).join(`
`),W=o=>!o||o.length===0?"No hay acciones definidas.":o.map((a,i)=>{const t=a.status==="done"?"(COMPLETADA)":"(PENDIENTE)";return`    * ${a.activity} [Resp: ${a.responsible}] [Vence: ${a.date}] ${t}`}).join(`
`),z=o=>!o||o.length===0?"No hay gráficos de seguimiento.":o.map((a,i)=>{const t=a.kpiType==="oee"?"OEE (Eficiencia General)":"Simple",p=a.goal?`${a.goal}${a.isPercentage?"%":""}`:"N/A";let c="";if(a.kpiType==="oee"){const n=a.dataPoints&&a.dataPoints.length>0?a.dataPoints[a.dataPoints.length-1]:null;if(n){const u=n.oee||"ND";c=`Último registro (${n.date}): OEE ${u}% (Disp: ${n.availability||"ND"}%, Rend: ${n.performance||"ND"}%, Cal: ${n.quality||"ND"}%)`}else c="Sin datos registrados."}else{const n=a.dataPoints||[];n.length>0?c=n.slice(-3).map(u=>`${u.date}: ${u.value}`).join(", "):c="Sin datos registrados."}return`  Gráfico #${i+1}: ${a.kpiName||"Sin nombre"} (${t})
    Meta: ${p}
    Datos: ${c}`}).join(`
`),x=(o,a)=>`
Ejes del Software "NEXUS BE LEAN":
    - Módulo 5S: Auditorías, hallazgos, acciones correctivas.
- Módulo Quick Wins: Mejoras rápidas de bajo costo.
- Módulo A3: Resolución de problemas(Ishikawa, 5 Porqués).
- Módulo VSM: Mapeo de flujo de valor (Estado Actual -> Estado Futuro).

        FECHA: ${new Date().toLocaleDateString("es-ES",{weekday:"long",year:"numeric",month:"long",day:"numeric"})}
    EMPRESA: ${a||"Cliente"}

TU ROL Y PODERES:
    1. Eres un mentor experto en Lean Manufacturing.
2. Tienes acceso SOLO a los datos de texto provistos aquí.NO tienes acceso a base de datos, no puedes borrar, editar ni ver otras empresas.
3. Todas las ideas o proyectos que sugieras deben ser atribuidos al usuario que pregunta.
4. NO puedes acceder al panel de administración ni cambiar configuraciones.

CAPACIDAD DE GENERACIÓN DE EJEMPLOS:
Si el usuario te pide un ejemplo(ej: "Dáme un ejemplo de A3 para seguridad"), debes generar una respuesta estructurada en Markdown que el usuario pueda copiar y usar.

FORMATO PARA EJEMPLOS DE PROYECTOS(A3):
Si te piden un ejemplo de A3, usa este formato:
## Ejemplo de Proyecto A3: [Título]
        ** Antecedentes **: [Descripción breve]
            ** Condición Actual **: [Datos cuantitativos del problema]
                ** Objetivo **: [Meta SMART]
                    ** Análisis Causa Raíz(Ishikawa sugerido) **:
    - Material: [Causa]
        - Método: [Causa]
            * (Incluye 5 Porqués simples)*
** Plan de Acción **:
    1.[Acción 1](Responsable: Usuario actual)
2.[Acción 2]

FORMATO PARA EJEMPLOS DE 5S:
## Ejemplo de Tarjeta 5S(Rojo)
        ** Hallazgo **: [Descripción]
            ** Ubicación **: [Lugar sugerido]
                ** Acción Correctiva **: [Acción]

                    === DATOS DE LA EMPRESA PARA ANÁLISIS ===


📋 TARJETAS 5S:
- Total Histórico: ${o.fiveS.total}
- Abiertas (Pendiente/Proceso): ${o.fiveS.pending+o.fiveS.inProcess}
- Cerradas (Finalizadas): ${o.fiveS.closed}
- Tasa de cierre: ${o.fiveS.rate}% (Promedio cierre: ${o.fiveS.avgClosure} días)
${o.fiveS.details.map(t=>`  • ${t.status?t.status.toUpperCase():"PENDIENTE"}: ${t.reason} (${t.location}) - ${t.responsible}`).join(`
`)}
${o.auditLogs&&o.auditLogs.length>0?`👉 ÚLTIMA AUDITORÍA 5S: Puntaje ${o.auditLogs[0].score}% (${o.auditLogs[0].date})`:""}

⚡ QUICK WINS:
- Total: ${o.quickWins.total} (Implementadas: ${o.quickWins.done}, Alto Impacto: ${o.quickWins.highImpact})
${o.quickWins.details.map(t=>`  • IDEA: ${t.title} (Impacto: ${t.impact}, Esfuerzo: ${t.effort}) - Estado: ${t.status}
    Detalle: "${t.description||"Sin descripción"}"`).join(`
`)}

📊 PROYECTOS A3:
- Total: ${o.a3.total}
${o.a3.details.length>0?o.a3.details.map(t=>`
> PROYECTO A3: "${t.title}" (Estado: ${t.status})
  1. DEFINICIÓN:
     - Antecedentes: ${t.background||"No definido"}
     - Condición Actual: ${t.currentCondition||"No definida"}
     - Objetivo: ${t.goal||"No definido"}
     - Responsable: ${t.responsible||"Sin asignar"}

  2. ANÁLISIS DE CAUSA:
     - Causa Raíz Identificada: ${t.rootCause||"No identificada"}
     - Diagramas de Ishikawa:
${G(t.ishikawas)}
     - 5 Porqués:
${J(t.fiveWhys)}

  3. PLAN Y SEGUIMIENTO:
     - Contramedidas (Estrategia): ${t.countermeasures||"No definidas"}
     - Plan de Acción:
${W(t.actionPlan)}
     - Métricas de Seguimiento (Gráficos):
${z(t.followUpData)}
`).join(`

------------------------------------------------------------

`):"No hay proyectos activos."}

🗺️ MAPAS VSM:
- Total: ${o.vsm.count}
${o.vsm.details&&o.vsm.details.length>0?o.vsm.details.map(t=>`  • VSM: "${t.name||"Sin nombre"}" (${t.status==="current"?"Estado Actual":t.status==="future"?"Estado Futuro":"Finalizado"})
    - Descripción: ${t.description||"N/A"}
    - Lead Time: ${t.leadTime||"ND"}
    - Tiempo Proceso: ${t.processTime||"ND"}
    - Eficiencia: ${t.efficiency||"ND"}
    - Takt Time: ${t.taktTime||"ND"}`).join(`
`):"No hay mapas VSM activos."}


=== TU ANÁLISIS ===
    1. Resumen Ejecutivo(Estado general).
2. Evaluación de Progreso(Coherencia metodológica).
3. Coaching(Errores detectados).
4. Acciones Recomendadas(Priorizadas).

REGLAS DE RESPUESTA:
- Si te piden ejemplos, usa la estructura de "CAPACIDAD DE GENERACIÓN DE EJEMPLOS".
- Si te preguntan por datos de otras empresas, aclara firmemente que no tienes acceso por seguridad.
- Mantén un tono profesional, motivador y educativo.
    `,_=(o,a="Cliente")=>{var v;const{fiveS:i,quickWins:t,vsms:p,a3:c,auditLogs:n}=o,u=i.filter(e=>{var d;return((d=e.status)==null?void 0:d.toLowerCase())==="cerrado"}).length,m=i.filter(e=>{var d;return((d=e.status)==null?void 0:d.toLowerCase())==="pendiente"}).length,E=i.filter(e=>{var d;return((d=e.status)==null?void 0:d.toLowerCase())==="en proceso"}).length,l=i.length>0?Math.round(u/i.length*100):0,h=i.filter(e=>e.status!=="Cerrado"&&e.date).map(e=>({...e,daysSince:Math.floor((new Date-new Date(e.date))/(1e3*60*60*24))})).sort((e,d)=>d.daysSince-e.daysSince),f=t.filter(e=>e.status==="done").length,g=t.filter(e=>e.status!=="done").length,T=t.filter(e=>e.status!=="done"&&e.impact==="Alto").length,r=c.filter(e=>e.status==="Cerrado").length,$=c.filter(e=>e.status==="En Proceso").length;let b=0,w=0;c.forEach(e=>{Array.isArray(e.actionPlan)&&(b+=e.actionPlan.length,w+=e.actionPlan.filter(d=>d.status==="done").length)});const L=b>0?Math.round(w/b*100):0,F=c.filter(e=>e.status!=="Cerrado").slice(0,50).map(e=>{var N,I;const d=(e.ishikawas||[]).map(s=>({problem:s.problem,rootCause:s.rootCause,categories:Object.entries(s.categories||{}).reduce((S,[C,P])=>(S[C]=(P||[]).map(A=>typeof A=="string"?A:A.text||""),S),{})})),R=(e.multipleFiveWhys||[]).map(s=>({problem:s.problem,rootCause:s.rootCause,whys:s.whys,status:s.status})),y=(s,S)=>{if(!S)return s;const C=parseFloat(s.availableTime)||0,P=parseFloat(s.productiveTime)||0,A=parseFloat(s.producedPieces)||0,U=parseFloat(s.defectPieces)||0,j=parseFloat(S.standardSpeed)||100,D=C>0?P/C*100:0,M=P*j>0?A/(P*j)*100:0,k=A>0?(A-U)/A*100:0,q=D*M*k/1e4;return{...s,availability:D.toFixed(1),performance:M.toFixed(1),quality:k.toFixed(1),oee:q.toFixed(1)}};return{title:e.title,status:e.status,responsible:e.responsible,background:e.background,currentCondition:e.currentCondition,goal:e.goal,rootCause:e.rootCause,countermeasures:e.countermeasures,actionPlan:(e.actionPlan||[]).map(s=>({activity:s.activity,responsible:s.responsible,date:s.date,status:s.status})),ishikawas:d,fiveWhys:R,followUpData:(e.followUpData||[]).map(s=>{const S=s.kpiType||"simple",C=s.oeeConfig||{},P=(s.dataPoints||[]).map(A=>S==="oee"?y(A,C):{date:A.date,value:A.value});return{kpiName:s.kpiName,kpiType:S,goal:s.kpiGoal,isPercentage:s.isPercentage,dataPoints:P}}),metrics:[],hasGoal:!!(e.goal&&e.goal.trim().length>0),actionCount:((N=e.actionPlan)==null?void 0:N.length)||0,actionsCompleted:((I=e.actionPlan)==null?void 0:I.filter(s=>s.status==="done").length)||0}});return{companyName:a,fiveS:{total:i.length,closed:u,pending:m,inProcess:E,rate:l,avgClosure:i.filter(e=>e.status==="Cerrado"&&e.date&&e.solutionDate).reduce((e,d,R,y)=>{const N=Math.abs(new Date(d.solutionDate)-new Date(d.date)),I=Math.ceil(N/(1e3*60*60*24));return e+I/y.length},0).toFixed(1),oldestPending:((v=h[0])==null?void 0:v.daysSince)||null,details:h.slice(0,50).map(e=>({id:e.id,status:e.status,reason:e.reason||"Sin descripción",location:e.location||"Sin ubicación",responsible:e.responsible||"Sin responsable",date:e.date,daysSince:e.daysSince}))},quickWins:{total:t.length,done:f,pending:g,highImpact:t.filter(e=>e.impact==="Alto").length,highImpactPending:T,details:t.filter(e=>e.status!=="done").slice(0,50).map(e=>({id:e.id,title:e.title,impact:e.impact,effort:e.effort,status:e.status,description:e.description}))},auditLogs:n?n.slice(0,5).map(e=>({date:e.date,score:e.score,auditor:e.auditor})):[],a3:{total:c.length,closed:r,inProcess:$,actionPlanRate:L,details:F},vsm:{count:p.length,details:p.map(e=>({name:e.name,status:e.status,description:e.description,leadTime:e.lead_time||e.leadTime,processTime:e.process_time||e.processTime,efficiency:e.efficiency,taktTime:e.takt_time||e.taktTime}))},auditHistory:{deletedItems:n?n.filter(e=>e.action==="DELETE").map(e=>{var d;return{type:e.entity_type,date:e.created_at,details:((d=e.details)==null?void 0:d.deletedData)||{},user:e.user_email}}).slice(0,15):[]}}},V=async(o,a,i)=>{var p,c,n,u,m,E;if(!i)throw new Error("API Key de Gemini no configurada");let t=x(o,a);t+=`
    
    === TU TAREA: ANÁLISIS INICIAL ===
    Genera un reporte de consultoría en formato JSON estricto.
    
    IMPORTANTE: DEBES RESPONDER SIEMPRE EN FORMATO JSON VÁLIDO CON LA SIGUIENTE ESTRUCTURA Y NADA MÁS:
    {
        "resumenEjecutivo": "Texto del resumen...",
        "metricaDestacada": { "nombre": "Nombre KPI", "valor": "Valor", "tendencia": "up|down|neutral" },
        "evaluacionProgreso": { "estado": "bueno|regular|critico", "observaciones": ["obs1", "obs2"] },
        "alertas": [{ "tipo": "critica|advertencia|info", "mensaje": "Texto alerta", "proyecto": "Opcional" }],
        "proximosPasos": [{ "titulo": "Acción", "descripcion": "Detalle", "prioridad": "alta|media|baja" }],
        "coachingPracticas": [{ "tema": "Titulo", "consejo": "Consejo detallado" }],
        "enfoqueDelDia": "Frase motivadora o foco técnico"
    }
    `;try{const l=await fetch(`${O}?key=${i}`,{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({contents:[{parts:[{text:t}]}],generationConfig:{temperature:.7,maxOutputTokens:8192,responseMimeType:"application/json"}})});if(!l.ok){const $=await l.json();throw new Error(((p=$.error)==null?void 0:p.message)||"Error en la API de Gemini")}const f=(E=(m=(u=(n=(c=(await l.json()).candidates)==null?void 0:c[0])==null?void 0:n.content)==null?void 0:u.parts)==null?void 0:m[0])==null?void 0:E.text;if(!f)throw new Error("Respuesta vacía de Gemini");const g=f.match(/\{[\s\S]*\}/),T=g?g[0]:f;let r;try{r=JSON.parse(T)}catch{throw console.error("JSON Parse Error. Raw text:",f),new Error("La IA no generó un formato válido. Intenta de nuevo.")}if(!r.resumenEjecutivo&&r.resumen&&(r.resumenEjecutivo=r.resumen),!r.resumenEjecutivo&&r.summary&&(r.resumenEjecutivo=r.summary),r.resumenEjecutivo||(r.resumenEjecutivo="El análisis se generó pero el resumen no tiene el formato esperado. Revisa las secciones detalladas."),r.alertas||(r.alertas=[]),r.proximosPasos||(r.proximosPasos=[]),r.coachingPracticas||(r.coachingPracticas=[]),!r.resumenEjecutivo)throw new Error("Análisis incompleto recibido. Reintentando...");return{...r,generatedAt:new Date().toISOString(),companyName:a,basePrompt:t}}catch(l){throw console.error("Error generating AI insight:",l),l}},Y=async(o,a,i,t,p)=>{var u,m,E,l,h,f;if(!p)throw new Error("API Key de Gemini no configurada");const n=[{role:"user",parts:[{text:x(i,t)+`

IMPORTANTE: A partir de ahora, responde como un asistente de chat conversacional. NO USES FORMATO MARKDOWN. NO uses negritas (**texto**), ni cursivas (*texto*), ni listas con asteriscos. Usa solo texto plano y listas con guiones simples (-) o números si es necesario. NO GENERES JSON.`}]},{role:"model",parts:[{text:"Entendido. Estoy listo para responder preguntas sobre los datos de mejora continua de la empresa."}]},...o.map(g=>({role:g.role==="user"?"user":"model",parts:[{text:g.content}]})),{role:"user",parts:[{text:a}]}];try{const g=await fetch(`${O}?key=${p}`,{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({contents:n,generationConfig:{temperature:.7,maxOutputTokens:1024}})});if(!g.ok){const $=await g.json();throw new Error(((u=$.error)==null?void 0:u.message)||"Error en el chat con Gemini")}const r=(f=(h=(l=(E=(m=(await g.json()).candidates)==null?void 0:m[0])==null?void 0:E.content)==null?void 0:l.parts)==null?void 0:h[0])==null?void 0:f.text;if(!r)throw new Error("Respuesta vacía del chat");return r}catch(g){throw console.error("Error in chat:",g),g}},H=async(o,a,i)=>{var p,c,n,u,m,E;if(!i)throw new Error("API Key de Gemini no configurada");const t=`
        Eres un experto en Lean Manufacturing y mejora continua.
        Problema: "${o}"
        Descripción: "${a}"

        Tu tarea:
        1. Propone una solución técnica técnica breve pero efectiva (máx 50 palabras).
        2. Incluye un beneficio esperado.
        3. Sé directo y práctico.
        
        Responde solo con el texto de la solución.
    `;try{const l=await fetch(`${O}?key=${i}`,{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({contents:[{parts:[{text:t}]}],generationConfig:{temperature:.7,maxOutputTokens:256}})});if(!l.ok){const g=await l.json();throw new Error(((p=g.error)==null?void 0:p.message)||"Error en la API de Gemini")}const f=(E=(m=(u=(n=(c=(await l.json()).candidates)==null?void 0:c[0])==null?void 0:n.content)==null?void 0:u.parts)==null?void 0:m[0])==null?void 0:E.text;if(!f)throw new Error("Respuesta vacía de Gemini");return f.trim()}catch(l){throw console.error("Error generating solution:",l),l}};export{V as a,H as g,_ as p,Y as s};
