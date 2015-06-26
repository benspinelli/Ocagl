type material_props = {ambient : Color.color;
                       diffuse : Color.color;
                       specular : Color.color;
                       emission : Color.color;
                       shininess : float}

type material = Solid of material_props

val mat_prop : Color.color -> Color.color -> Color.color -> Color.color -> 
               float -> material_props

val solid : material_props -> material
