from mcstatus import MinecraftServer
from fastapi import APIRouter
from fdl_api.models.server_stats import Players, ServerStats

router = APIRouter(prefix="/stats", tags=["minecraft", "stats"])


async def __get_stats(ip: str, port: int = 25565) -> ServerStats:
    server = MinecraftServer(ip, port)
    status = await server.async_status()
    query = await server.async_query()

    return ServerStats(
        ip=ip,
        port=port,
        description=status.description,
        version=status.version.name,
        latency=status.latency,
        players=Players(
            online=query.players.online,
            max=query.players.max,
            list=query.players.names,
        ),
    )


@router.get("/main", response_model=ServerStats)
async def main_stats():
    return await __get_stats("play.fdl-mc.ru")


@router.get("/creative", response_model=ServerStats)
async def creative_stats():
    return await __get_stats("creative.fdl-mc.ru")
