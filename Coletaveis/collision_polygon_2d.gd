extends CollisionPolygon2D
var col = $CollisionPolygon2D
if col:
	col.disabled = true

# ou desativar a detecção do Area2D
self.monitoring = false
