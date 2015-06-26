type material_props = {ambient : Color.color;
                       diffuse : Color.color;
                       specular : Color.color;
                       emission : Color.color;
                       shininess : float}

type material = Solid of material_props

val mat_prop ambient diffuse specular emission shininess =
    {ambient; diffuse; specular; emission; shininess}

val solid p = Solid p
