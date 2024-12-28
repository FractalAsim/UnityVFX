using UnityEditor;
public class CutoffSectionBoxShaderGUI : ShaderGUI
{
    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        MaterialProperty _Enable = FindProperty("_Enable", properties);
        MaterialProperty _MinX = FindProperty("_MinX", properties);
        MaterialProperty _MaxX = FindProperty("_MaxX", properties);
        MaterialProperty _MinY = FindProperty("_MinY", properties);
        MaterialProperty _MaxY = FindProperty("_MaxY", properties);
        MaterialProperty _MinZ = FindProperty("_MinZ", properties);
        MaterialProperty _MaxZ = FindProperty("_MaxZ", properties);

        materialEditor.DefaultShaderProperty(_Enable, "_Enable");
        materialEditor.DefaultShaderProperty(_MinX, "_MinX");
        materialEditor.DefaultShaderProperty(_MaxX, "_MaxX");
        materialEditor.DefaultShaderProperty(_MinY, "_MinY");
        materialEditor.DefaultShaderProperty(_MaxY, "_MaxY");
        materialEditor.DefaultShaderProperty(_MinZ, "_MinZ");
        materialEditor.DefaultShaderProperty(_MaxZ, "_MaxZ");

        StandardShaderGUI t = new();
        t.OnGUI(materialEditor, properties);
    }
}